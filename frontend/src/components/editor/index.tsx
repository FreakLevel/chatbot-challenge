import { useContext, useEffect, useRef, useState } from "react"
import { useChat } from '@src/contexts/chatContext'
import './style.css'

interface IProps {
  editorAvailable: boolean,
  changeEditorAvailable: (available: boolean) => void
}
const Editor = ({
  editorAvailable,
  changeEditorAvailable
}: IProps) => {
  const ref = useRef(null);
  const [state,] = useChat()
  const [text, setText] = useState<string>('')

  useEffect(() => {
    const keyDownHandler = (event: any) => {
      if(event.key === 'Enter' && document.activeElement === ref.current) {
        event.preventDefault()
        sendMessage()
      }
    }
    document.addEventListener('keydown', keyDownHandler)
    return () => document.removeEventListener('keydown', keyDownHandler)
  }, [])

  const sendMessage = () => {
    const input = state.messages[state.messages.length - 1].input
    console.log(`Input: ${input}`)
    const message = ref.current.value
    if(message === '') return
    ref.current.value = ''
    changeEditorAvailable(false)
    state.channel.sendMessage({
      input: input,
      value: message
    })
  }

  return(
    <div className="editorContainer">
      <input
        readOnly={!editorAvailable}
        ref={ref}
        autoFocus
        placeholder="Responde aquí"
        className='messageInput'
        value={text}
        onChange={(evt: React.ChangeEvent<HTMLInputElement>) => setText(evt.target.value)}
      />
    </div>
  )
}

export default Editor
