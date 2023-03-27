import Messages from '@src/components/messages'
import Editor from '@src/components/editor'
import './style.css'
import { useCallback, useEffect, useState } from 'react'
import { useChat } from '../../contexts/chatContext'

interface IProps {
  openConnection: (dispatcher: any) => void
}

const Chat = ({ openConnection }: IProps) => {
  const [editorAvailable, setEditorAvailable] = useState<boolean>(false)

  const [, dispatch]: any = useChat()

  useEffect(() => {
    if(dispatch === null || dispatch === undefined) return
    openConnection(dispatch)
  }, [dispatch])

  const changeEditorAvailable = (value: boolean) => setEditorAvailable(value)

  return(
    <div className='container'>
      <div className='chat'>
        <Messages changeEditorAvailable={changeEditorAvailable}/>
        <Editor
          editorAvailable={editorAvailable}
          changeEditorAvailable={setEditorAvailable}
        />
      </div>
    </div>
  )
}

export default Chat
