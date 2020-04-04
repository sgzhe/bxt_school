class ChatChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    Chat.all.each do |chat|
      stream_from "chat_#{chat.id}"
    end
  end

  def unsubscribed
    stop_all_streams
  end
end
