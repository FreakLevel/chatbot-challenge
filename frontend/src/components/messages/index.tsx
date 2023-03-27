import { useEffect, useRef } from "react"
import { useChat } from '@src/contexts/chatContext'
import ReactMarkdown from 'react-markdown'
import './style.css'

interface IProps {
  changeEditorAvailable: (available: boolean) => void
}

const Messages =  ({ changeEditorAvailable } :IProps) => {
  const [state,] = useChat()
  const dummy = useRef(null)

  useEffect(() => {
    if (dummy.current) {
      dummy.current.scrollIntoView({ behavior: 'smooth' })
    }
    if (state.messages.length <= 0) return
    const message = state.messages[state.messages.length - 1]
    if (message.input !== null) changeEditorAvailable(true)
  }, [state.messages.length])

  const renderMessages = () => (
    state.messages.map((message: any) => {
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
