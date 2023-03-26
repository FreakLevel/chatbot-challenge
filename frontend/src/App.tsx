import './App.css'
import cable from './websocket/cable'
import ChatbotChannel from './websocket/chatbotChannel'
import { useEffect, useReducer, useState } from 'react' 
import { initialState, reducer } from './reducer'
import { ChatContext } from './contexts/chatContext'
import Chat from './components/Chat'

function App() {
  const [loading, setLoading] = useState(false)
  ChatContext.displayName = 'ChatContext'

  const [state, dispatch] = useReducer(reducer, initialState)

  useEffect(() => {
    const channel = new ChatbotChannel(dispatch)
    cable.subscribe(channel)
    setLoading(true)
    channel.ensureSubscribed().then(
      () => setLoading(false)
    )
    channel.test()
  }, [])

  return (
    <div className="App">
      <ChatContext.Provider value={state as any}>
        {
          loading
            ? <h1>Loading</h1>
            : <Chat />
        } 
      </ChatContext.Provider>
    </div>
  )
}

export default App
