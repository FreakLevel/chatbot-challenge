import { useEffect, useState } from 'react'
import './App.css'
import Chat from './components/chat'
import cable from './websocket/cable'
import { ChatChannel } from './websocket/chatbotChannel'
import { ChatContextProvider } from './contexts/chatContext'
import { chatReducer, initialState } from './reducer'
import { SET_CHANNEL } from './actions'

function App() {
  const [initedConversation, setInitedConversation] = useState<boolean>(false)

  // const connectChannel = (dispatcher: any) => {
  //   if(dispatcher === null || dispatcher === undefined) return
  //   const channel = ChatChannel.getInstance(dispatcher)
  //   cable.subscribe(channel)
  //   if(initedConversation) return
  //   dispatcher({ type: SET_CHANNEL, channel: channel })
  //   channel.ensureSubscribed().then(() => {
  //     setInitedConversation(true)
  //     channel.initConversation()
  //   })
  // }

  useEffect(() => console.count('Render App'))

  return (
    <div className="App">
      <ChatContextProvider initialState={initialState} reducer={chatReducer}>
        <Chat />
      </ChatContextProvider>
    </div>
  )
}

export default App
