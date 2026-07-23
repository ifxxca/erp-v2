import { resolve } from 'node:path'
import { spawnSync } from 'node:child_process'

const repositoryRoot = resolve(import.meta.dirname, '..', '..', '..')
const generatedPath = 'packages/api-client-dart'

function git(args, capture = false) {
  const result = spawnSync('git', args, {
    cwd: repositoryRoot,
    encoding: capture ? 'utf8' : undefined,
    stdio: capture ? 'pipe' : 'inherit',
    shell: false,
  })
  if (result.error) throw result.error
  return result
}

const changed = git(['diff', '--exit-code', '--', generatedPath])
if (changed.status !== 0) process.exit(changed.status ?? 1)

const untracked = git(['ls-files', '--others', '--exclude-standard', '--', generatedPath], true)
if (untracked.status !== 0) process.exit(untracked.status ?? 1)
if (untracked.stdout.trim()) {
  console.error(`Generated Dart client contains untracked files:\n${untracked.stdout.trim()}`)
  process.exit(1)
}

console.log('Generated Dart client matches the committed output.')
