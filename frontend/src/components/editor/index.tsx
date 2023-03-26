import { useEffect, useRef, useState } from "react"
import './style.css'

const Editor = () => {
  const ref = useRef(null);

  useEffect(() => {
    if (!document.activeElement === ref.current) return
    const keyDownHandler = (event: any) => {
      if(event.key === 'Enter') {
        event.preventDefault()
        sendMessage()
      }
    }
    document.addEventListener('keydown', keyDownHandler)
    return () => document.removeEventListener('keydown', keyDownHandler)
  }, [])

  const sendMessage = () => {
    const message = ref.current.value
    if(message === '') return
    ref.current.value = ''
    console.log(message)
  }

  return(
    <div className="editorContainer">
      <input
        ref={ref}
        autoFocus
        placeholder="Responde aquí"
        className='messageInput'
      />
    </div>
  )
}

export default Editor
