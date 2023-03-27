import { useEffect, useRef } from "react"
import './style.css'
import { ChatChannel } from "@src/websocket/chatbotChannel"

interface IProps {
  editorAvailable: boolean,
  changeEditorAvailable: (available: boolean) => void,
  input: string | null,
}
const Editor = ({
  editorAvailable,
  changeEditorAvailable,
  input,
}: IProps) => {
  const ref = useRef<HTMLInputElement|null>(null);
  const inputRef = useRef<string|null>(input);

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

  useEffect(() => {
    inputRef.current = input
  }, [input])

  const sendMessage = () => {
    if(ref.current === null) return
    const channel = ChatChannel.getInstance()
    const message = ref.current.value
    if(message === '') return
    ref.current.value = ''
    const inputValue = inputRef.current
    changeEditorAvailable(false)
    channel.sendMessage({
      input: inputValue,
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
      />
    </div>
  )
}

export default Editor
