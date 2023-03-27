import { Channel } from "@anycable/web"
import { ChannelEvents } from "@anycable/core"
import { Dispatch } from "react"

type Params = {}
type Message = {
  type: 'message'
}
interface Events extends ChannelEvents<Message> {}

class ChatbotChannel extends Channel<Params, Message, Events> {
  static identifier = 'ChatbotChannel'

  dispatch: Dispatch<unknown>

  constructor(addMessage: any) {
    super()
    this.dispatch = addMessage
    return this
  }

  async initConversation() {
    this.perform('init_conversation')
  }

  async sendMessage(payload: any) {
    this.perform('receive_message', payload)
    this.dispatch({
      key: crypto.randomUUID(),
      from: 'human',
      text: payload.value,
      input: null
    })
  }

  receive(message: any) {
    this.dispatch(message.data)
  }
}

export const ChatChannel = (function () {
    var instance: any;

    function createInstance(dispatcher: any) {
      return new ChatbotChannel(dispatcher)
    }

    return {
      getInstance: function (dispatcher: any = null) {
        if (!instance) {
          if (dispatcher === null) { throw Error('Can not initialize without dispatcher') }
          instance = createInstance(dispatcher)
        }
        return instance
      }
    };
})();
