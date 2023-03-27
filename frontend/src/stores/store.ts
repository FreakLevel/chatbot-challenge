import { atom } from 'jotai'

interface IChatContext {
  messages: any[],
  channel: any,
  input: string | null
}

export const chatStore = atom<IChatContext>({
  messages: [],
  channel: null,
  input: null
})
