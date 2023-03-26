import { Channel } from "@anycable/web"
import { ChannelEvents } from "@anycable/core"
import { Dispatch } from "react"
import {
  SET_NEW_MESSAGE
} from '../actions'

type Params = {}
type Message = {
  type: 'message'
}
interface Events extends ChannelEvents<Message> {
  typing: (msg: Message) => void
}

export default class ChatbotChannel extends Channel<Params, Message, Events> {
  static identifier = 'ChatbotChannel'

  dispatch: Dispatch<unknown>

  constructor(dispatch: any) {
    super()
    this.dispatch = dispatch
  }

  async test() { this.perform('test') }

  receive(message: any) {
    this.dispatch({ type: SET_NEW_MESSAGE, payload: message.data })
  }
}
