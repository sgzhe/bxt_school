class Bed
  include Mongoid::Document

  field :mark, type: String
  field :desc, type: String, default: ''
  field :owner_name, type: String, default: ''

  belongs_to :owner, class_name: 'User', required: false
  embedded_in :room, class_name: 'Room'

  set_callback(:save, :before) do |doc|
    doc.owner_name =  doc.owner.name if doc.owner
  end

end
