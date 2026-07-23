import { existsSync, readFileSync, readdirSync, rmSync, writeFileSync } from 'node:fs'
import { dirname, resolve } from 'node:path'
import { spawnSync } from 'node:child_process'
import { fileURLToPath } from 'node:url'

const GENERATOR_IMAGE = 'openapitools/openapi-generator-cli:v7.22.0'
const DART_IMAGE = 'dart:3.12.2-sdk'
const scriptDirectory = dirname(fileURLToPath(import.meta.url))
const repositoryRoot = resolve(scriptDirectory, '..', '..', '..')
const contractDirectory = resolve(repositoryRoot, 'packages', 'api-contract')
const outputDirectory = resolve(repositoryRoot, 'packages', 'api-client-dart')

if (outputDirectory !== resolve(repositoryRoot, 'packages', 'api-client-dart')) {
  throw new Error(`Refusing to replace unexpected output directory: ${outputDirectory}`)
}

const contract = readFileSync(resolve(contractDirectory, 'openapi.yaml'), 'utf8')
const configuration = readFileSync(resolve(contractDirectory, 'dart-generator.yaml'), 'utf8')
const lockfilePath = resolve(outputDirectory, 'pubspec.lock')
const existingLockfile = existsSync(lockfilePath) ? readFileSync(lockfilePath, 'utf8') : null
const contractVersion = contract.match(/^  version:\s*([^\s#]+)/m)?.[1]
const packageVersion = configuration.match(/^  pubVersion:\s*([^\s#]+)/m)?.[1]

if (!contractVersion || contractVersion !== packageVersion) {
  throw new Error(`Dart package version ${packageVersion ?? '(missing)'} must match OpenAPI version ${contractVersion ?? '(missing)'}.`)
}

function dockerPath(path) {
  return path.replaceAll('\\', '/')
}

function run(command, args) {
  const result = spawnSync(command, args, { cwd: repositoryRoot, stdio: 'inherit', shell: false })
  if (result.error) throw result.error
  if (result.status !== 0) process.exit(result.status ?? 1)
}

function normalizeGeneratedText(directory) {
  for (const entry of readdirSync(directory, { withFileTypes: true })) {
    if (entry.name === '.dart_tool') continue

    const path = resolve(directory, entry.name)
    if (entry.isDirectory()) {
      normalizeGeneratedText(path)
      continue
    }

    if (!entry.name.endsWith('.dart') && !entry.name.endsWith('.md')) continue

    const content = readFileSync(path, 'utf8')
    const normalized = content.replace(/[\t ]+$/gm, '').replace(/(?:\r?\n)+$/, '\n')
    if (normalized !== content) writeFileSync(path, normalized)
  }
}

rmSync(outputDirectory, { recursive: true, force: true })

run('docker', [
  'run', '--rm',
  '-v', `${dockerPath(repositoryRoot)}:/local`,
  GENERATOR_IMAGE,
  'generate',
  '-c', '/local/packages/api-contract/dart-generator.yaml',
  '-i', '/local/packages/api-contract/openapi.yaml',
  '-o', '/local/packages/api-client-dart',
])

if (existingLockfile) writeFileSync(lockfilePath, existingLockfile)

run('docker', [
  'run', '--rm',
  '-v', `${dockerPath(outputDirectory)}:/app`,
  '-w', '/app',
  DART_IMAGE,
  'bash', '-c',
  'dart pub get && dart run build_runner build && dart analyze --no-fatal-warnings',
])

normalizeGeneratedText(outputDirectory)

const generatedPubspec = readFileSync(resolve(outputDirectory, 'pubspec.yaml'), 'utf8')
const generatedVersion = generatedPubspec.match(/^version:\s*([^\s#]+)/m)?.[1]
if (generatedVersion !== contractVersion) {
  throw new Error(`Generated Dart package version ${generatedVersion ?? '(missing)'} does not match OpenAPI version ${contractVersion}.`)
}
