class ChatChannel < ApplicationCable::Channel
  def subscribed
      stream_from "chat_1"
  end

  def unsubscribed
    stop_all_streams
  end

  def speak(data)
    ActionCable.server.broadcast(
        "chat_1",
        message: data
    )
  end
end
