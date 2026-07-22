import './App.css'

const pilotCapabilities = [
  'Vehicle status',
  'Daily checklist',
  'Odometer tracking',
  'Maintenance work order',
]

function App() {
  return (
    <main className="shell">
      <div className="badge">Pilot · RKS / Warehouse Kresek</div>
      <p className="eyebrow">Rajawali Operations</p>
      <h1>Fleet &amp; Maintenance</h1>
      <p className="lead">
        Mobile-first operations surface. Offline mutation, authentication, dan
        production data belum diaktifkan pada scaffold ini.
      </p>
      <section aria-label="Pilot capabilities">
        {pilotCapabilities.map((capability, index) => (
          <article key={capability}>
            <span>{String(index + 1).padStart(2, '0')}</span>
            <strong>{capability}</strong>
          </article>
        ))}
      </section>
    </main>
  )
}

export default App
