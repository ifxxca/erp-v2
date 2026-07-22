import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { createTheme, MantineProvider } from '@mantine/core'
import { Notifications } from '@mantine/notifications'
import '@mantine/core/styles.css'
import '@mantine/notifications/styles.css'
import './index.css'
import App from './App.tsx'

const theme = createTheme({
  primaryColor: 'forest',
  primaryShade: 8,
  defaultRadius: 'md',
  fontFamily: 'Inter, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif',
  colors: {
    forest: ['#eef8f3', '#dceee5', '#b9ddcb', '#91c9af', '#70b898', '#5bab87', '#4e9f7d', '#3d8b6b', '#2d7055', '#174f3a'],
  },
  components: {
    Button: { defaultProps: { fw: 700 } },
    Card: { defaultProps: { radius: 'lg', withBorder: true } },
    InputWrapper: { defaultProps: { fw: 600 } },
  },
})

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <MantineProvider theme={theme} defaultColorScheme="light" deduplicateInlineStyles>
      <Notifications position="top-right" />
      <App />
    </MantineProvider>
  </StrictMode>,
)
