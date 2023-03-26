import { useContext } from "react"
import { ChatContext } from '../../contexts/chatContext'

export default () => {
  const { messages } = useContext(ChatContext)
  const renderMessages = () => (
    messages.map(message => <p>{message.text}</p>)
  )
  return(renderMessages())
}
