import { useContext, useEffect, useRef } from "react"
import { ChatContext } from '@src/contexts/chatContext'
import ReactMarkdown from 'react-markdown'
import './style.css'

const Messages =  () => {
  const { messages } = useContext<ChatContext>(ChatContext)
  const dummy = useRef(null)

  useEffect(() => {
    if (dummy.current) {
      dummy.current.scrollIntoView({ behavior: 'smooth' })
    }
  }, [messages.length])

  const renderMessages = () => (
    messages.map((message: any) => {
      const cssClasses = `message ${message.from}Message`
      const key = `message-${message.key}`
      return(
        <div className={cssClasses} key={key}>
          <ReactMarkdown>{message.text}</ReactMarkdown>
        </div>
      )
    })
  )
  return(
    <div className="messages">
      { renderMessages() }
      <div ref={dummy} />
    </div>
  )
}

export default Messages
