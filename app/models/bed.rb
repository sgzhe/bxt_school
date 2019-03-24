class Bed
  include Mongoid::Document

  field :bed_no, type: String
  field :desc
  field :owner_name

  belongs_to :owner, class_name: 'User', required: false
  embedded_in :room, class_name: 'Room'

  def title
    "#{bed_no}床"
  end

  set_callback(:save, :before) do |doc|
    doc.owner_name =  doc.owner.name if doc.owner
  end

end
