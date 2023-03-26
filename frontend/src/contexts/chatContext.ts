import { createContext } from "react"

export interface IChatContext {
  messages: any[]
}

const initialState: IChatContext = {
  messages: []
}

export const ChatContext = createContext(initialState)
