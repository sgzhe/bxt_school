class Org
  include ModelBase
  include Mongoid::Tree
  include Mongoid::Tree::Traversal

  field :title
  field :full_title

  has_many :users, class_name: 'User', foreign_key: :org_id, inverse_of: :org, validate: false, dependent: :restrict_with_exception

  default_scope -> { order_by(id: -1) }

  set_callback(:save, :before) do |doc|
    if doc.parent
      doc.full_title =  doc.parent.full_title + '>>' + doc.title
    else
      doc.full_title = doc.title
    end
  end


end
