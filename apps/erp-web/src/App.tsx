import './App.css'

const decisions = [
  'Multi-company isolation',
  'Scoped role assignments',
  'Auditable approval flows',
  'Contract-first API',
]

function App() {
  return (
    <main className="shell">
      <p className="eyebrow">Rajawali Platform V2</p>
      <h1>Management ERP</h1>
      <p className="lead">
        Foundation workspace untuk procurement, inventory, finance, fleet, dan
        reporting. Business capability akan ditambahkan sebagai vertical slice.
      </p>
      <ul>
        {decisions.map((decision) => (
          <li key={decision}>{decision}</li>
        ))}
      </ul>
      <p className="status">Foundation scaffold · belum terhubung ke production data</p>
    </main>
  )
}

export default App
