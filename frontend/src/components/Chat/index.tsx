import Messages from '@src/components/messages'
import Editor from '@src/components/editor'
import './style.css'

const Chat = () => {
  return(
    <div className='container'>
      <div className='chat'>
        <Messages/>
        <Editor />
      </div>
    </div>
  )
}

export default Chat
