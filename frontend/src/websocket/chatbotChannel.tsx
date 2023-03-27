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

class ChatbotChannel extends Channel<Params, Message, Events> {
  static identifier = 'ChatbotChannel'

  dispatch: Dispatch<unknown>

  constructor(dispatch: any) {
    super()
    this.dispatch = dispatch
    return this
  }

  async initConversation() {
    this.perform('init_conversation')
  }

  async sendMessage(payload: any) {
    this.perform('receive_message', payload)
    this.dispatch({
      type: SET_NEW_MESSAGE,
      payload: {
        key: crypto.randomUUID(),
        from: 'human',
        text: payload.value,
        input: null
      }
    })
  }

  receive(message: any) {
    this.dispatch({ type: SET_NEW_MESSAGE, payload: message.data })
  }
}

export const ChatChannel = (function () {
    var instance;

    function createInstance(dispatcher: any) {
      var channel = new ChatbotChannel(dispatcher)
      return channel
    }

    return {
      getInstance: function (dispatcher: any) {
        if (!instance) {
            instance = createInstance(dispatcher)
        }
        return instance
      }
    };
})();