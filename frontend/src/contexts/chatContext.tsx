import { createContext, useContext, useReducer } from "react";
import { IAction } from "../reducer";

const Store = createContext()
Store.displayName = 'Store'

export const useChat = () => useContext(Store)


interface IChatContext {
  messages: any[],
  channel: any,
  input: string | null
}

interface IChatContextProvider {
  children: JSX.Element,
  initialState: IChatContext,
  reducer: (state: IChatContext | undefined, action: IAction) => any
}

export const ChatContextProvider = ({
  children,
  initialState,
  reducer
}: IChatContextProvider) => {
  const [state, dispatch] = useReducer(reducer, initialState)

  return(
    <Store.Provider value={[state, dispatch]}>
      { children }
    </Store.Provider>
  )
}


//
//
//
//
//
//
//
//
//
//import { createContext, useContext, useEffect, useReducer } from "react"
//import { SET_CHANNEL } from "../actions"
//import { IReducerChatContext, reducer } from "../reducer"
//import cable from "../websocket/cable"
//import ChatbotChannel from "../websocket/chatbotChannel"
//
//export interface IChatContext {
//  messages: any[],
//  channel: any,
//  input: null | string
//}
//
//const initialState: IChatContext = {
//  messages: [],
//  channel: null,
//  input: null
//}
//
//const ChatContext = createContext<IChatContext|null>(null)
//
//const ChatContextDispatcher = createContext<IReducerChatContext|null>(null)
//
//interface IProps { children: any }
//
//export function ChatContextProvider ({ children }: IProps) {
//  const [chat, dispatch] = useReducer(reducer, initialState)
//
//  useEffect(() => {
//    const channel = new ChatbotChannel(dispatch)
//    cable.subscribe(channel)
//    channel.ensureSubscribed().then(
//      () => {
//        channel.initConversation()
//      }
//    )
//    dispatch({ type: SET_CHANNEL, payload: channel })
//  }, [])
//
//  return(
//    <ChatContext.Provider value={chat as IChatContext}>
//      <ChatContextDispatcher.Provider value={dispatch as any}>
//        { children }
//      </ChatContextDispatcher.Provider>
//    </ChatContext.Provider>
//  )
//}
//
//export const useChat = () => useContext(ChatContext)
//
//export const useChatDispatch = () => useContext(ChatContextDispatcher)
