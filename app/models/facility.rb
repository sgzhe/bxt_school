class Facility
  include ModelBase
  include Mongoid::Tree

  field :title, type: String, default: ''
  field :full_title, type: String, default: ''
  field :mark, type: String, default: ''

  default_scope -> { order_by(seq: 1, id: -1) }

  belongs_to :owner, foreign_key: :owner_id, class_name: 'User', required: false
  has_many :users, class_name: 'User', foreign_key: :dorm_id, inverse_of: :facility, validate: false, dependent: :restrict_with_exception

  set_callback(:save, :before) do |doc|
    if doc.parent
      doc.full_title =  doc.parent.full_title + '>>' + doc.title
    else
      doc.full_title = doc.title
    end

  end
end
