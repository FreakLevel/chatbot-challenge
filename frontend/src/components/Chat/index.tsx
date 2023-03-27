import Messages from '@src/components/messages'
import Editor from '@src/components/editor'
import './style.css'
import { useCallback, useEffect, useState } from 'react'
import cable from "@src/websocket/cable"
import { ChatChannel } from "@src/websocket/chatbotChannel"
import { useAtom } from "jotai"
import { chatStore } from "@src/stores/store"

const Chat = () => {
  const [editorAvailable, setEditorAvailable] = useState<boolean>(false)

  const changeEditorAvailable = (value: boolean) => setEditorAvailable(value)
  
  const [chat, setChatStore] = useAtom(chatStore)
  const [initedConversation, setInitedConversation] = useState<boolean>(false)
  const [lastInputType, setLastInputType] = useState<string|null>(null)

  const addMessage = (message: any) => {
    setChatStore((chatStore) => ({
      ...chatStore,
      messages: chatStore.messages.concat(message),
      input: message.input
    }))
    setLastInputType(message.input)
  }
  
  useEffect(() => {
    const channel = ChatChannel.getInstance(addMessage)
    cable.subscribe(channel)
    channel.ensureSubscribed().then(() => {
      if(initedConversation) return
      channel.initConversation()
      setInitedConversation(true)
    })
  }, [])

  return(
    <div className='container'>
      <div className='chat'>
        <Messages chat={chat} changeEditorAvailable={changeEditorAvailable}/>
        <Editor
          editorAvailable={editorAvailable}
          changeEditorAvailable={setEditorAvailable}
          input={chat.input}
        />
      </div>
    </div>
  )
}

export default Chat
