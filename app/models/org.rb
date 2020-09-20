class Org
  include ModelBase
  include Mongoid::Tree
  include Mongoid::Tree::Ordering
  include Mongoid::Tree::Traversal

  field :title, type: String, default: ''
  field :full_title, type: String, default: ''

  has_many :users, class_name: 'User', foreign_key: :dept_id, inverse_of: :dept, validate: false, dependent: :restrict_with_exception

  #default_scope -> { order_by(id: -1) }

  set_callback(:save, :before) do |doc|
    if doc.parent
      doc.full_title =  doc.parent.full_title + '>>' + doc.title
    else
      doc.full_title = doc.title
    end
  end


end
