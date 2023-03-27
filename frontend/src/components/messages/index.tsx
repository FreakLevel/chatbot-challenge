import { useEffect, useRef } from "react"
import ReactMarkdown from 'react-markdown'
import remarkGfm from 'remark-gfm'
import './style.css'

interface IProps {
  changeEditorAvailable: (available: boolean) => void,
  chat: any
}

const Messages =  ({ changeEditorAvailable, chat } :IProps) => {
  const dummy = useRef<HTMLDivElement|null>(null)

  useEffect(() => {
    if (dummy.current) {
      dummy.current.scrollIntoView({ behavior: 'smooth' })
    }
    if (chat.messages.length <= 0) return
    const message = chat.messages[chat.messages.length - 1]
    if (message.input !== null) changeEditorAvailable(true)
  }, [chat.messages.length])

  const renderMessages = () => (
    chat.messages.map((message: any) => {
      const cssClasses = `message ${message.from}Message`
      const key = `message-${message.key}`
      return(
        <div className={cssClasses} key={key}>
          <ReactMarkdown remarkPlugins={[remarkGfm]} children={message.text} />
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
