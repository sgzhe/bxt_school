class Message
  include ModelBase
  field :cont, type: String, default: ''

  belongs_to :user, required: false
  belongs_to :chat, required: false

  set_callback(:save, :after) do |doc|
    ActionCable.server.broadcast "chat_#{doc.chat_id}", message: doc.cont
  end
end