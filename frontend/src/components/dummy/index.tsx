import { useAtom } from "jotai"
import { useEffect, useState } from "react"
import { chatStore } from "../../stores/store"
import cable from "../../websocket/cable"
import { ChatChannel } from "../../websocket/chatbotChannel"

const Dummy = () => {
  const [, setChatStore] = useAtom(chatStore)
  const [initedConversation, setInitedConversation] = useState<boolean>(false)

  const addMessage = (message: any) => {
    setChatStore((chatStore) => ({
      ...chatStore,
      messages: chatStore.messages.concat(message),
      input: message.input
    }))
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

  return(<></>)
}

export default Dummy
