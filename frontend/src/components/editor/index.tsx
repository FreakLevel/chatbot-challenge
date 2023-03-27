import { useEffect, useRef } from "react"
import './style.css'
import { ChatChannel } from "../../websocket/chatbotChannel"

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
  const ref = useRef(null);
  const inputRef = useRef(input);

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
    console.count('Change input')
    console.log(`Input: ${inputRef.current}`)
  }, [input])

  const sendMessage = () => {
    const channel = ChatChannel.getInstance(null)
    const message = ref.current.value
    if(message === '') return
    ref.current.value = ''
    const inputValue = inputRef.current
    console.log(`Input: ${inputValue}`)
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
