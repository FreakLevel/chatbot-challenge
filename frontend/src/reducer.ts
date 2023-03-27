import { SET_CHANNEL, SET_NEW_MESSAGE } from "./actions"

interface IChatContext {
  messages: any[],
  channel: any,
  input: string | null
}

export const initialState: IChatContext = {
  messages: [],
  channel: null
}

interface IMessage {
  key: string,
  from: 'bot' | 'human',
  text: string,
  input: string | null
}

export const addNewMessage = (message: IMessage) => ({
  type: SET_NEW_MESSAGE,
  message
})

export interface IAction {
  type: string,
  payload?: IMessage,
  channel?: any
}

export const chatReducer = (state = initialState, action: IAction) => {
  if(action === null || action === undefined) return state
  switch(action.type) {
    case SET_NEW_MESSAGE:
      return handleNewMessage(state, action.payload)
    case SET_CHANNEL:
      debugger
      return { ...state, channel: action.channel }
    default:
      throw Error(`Unknow action: ${action.type}`);
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
  if(sameMessageIndex >= 0) return currentState
  messages.push(payload)
  return {
    ...currentState,
    messages: messages
  }
}
