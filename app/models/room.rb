class Room < Facility

  field :floor_mark
  field :total_beds, type: Integer
  field :vacant_beds, type: Integer

  belongs_to :house, class_name: 'House', foreign_key: :parent_id, inverse_of: :rooms, required: false
  has_many :beds, class_name: 'Bed', foreign_key: :parent_id, inverse_of: :room, validate: false, dependent: :restrict_with_exception
  has_many :students, class_name: 'Student', foreign_key: :facility_id, inverse_of: :room, validate: false, dependent: :restrict_with_exception
  has_many :teachers, class_name: 'Teacher', foreign_key: :facility_id, inverse_of: :room, validate: false, dependent: :restrict_with_exception

  def floor
    house.floors.detect { |floor| floor.mark == floor_mark }
  end
end
