import { SET_NEW_MESSAGE } from './actions'
import { IChatContext } from './contexts/chatContext'

interface IAction {
  type: string
  payload: any
}

export const initialState: IChatContext = {
  messages: []
}

export const reducer: any = (oldState: IChatContext, action: IAction) => {
  switch (action.type) {
    case SET_NEW_MESSAGE:
      return handleNewMessage(oldState, action.payload)
    default:
      throw "Unhandled server message";
  }
}

const handleNewMessage = (
  currentState: IChatContext,
  payload: IAction['payload']
) => {
  const sameMessageIndex = currentState.messages
    .findIndex(
      message => message.key == payload.key
    )
  const messages = currentState.messages
  if(sameMessageIndex < 0) messages.push(payload)
  return {
    ...currentState,
    messages: messages
  }
}

