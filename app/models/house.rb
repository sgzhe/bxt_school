class House < Facility
  field :closing_at, type: Float, default: 0.0

  has_many :floors, class_name: 'Floor', foreign_key: :parent_id, inverse_of: :house, validate: false, dependent: :restrict_with_exception


end
