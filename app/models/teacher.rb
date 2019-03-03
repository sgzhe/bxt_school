class Teacher < User

  belongs_to :department, class_name: 'Department', foreign_key: :org_id, inverse_of: :teachers, required: false
  belongs_to :bed, class_name: 'Bed', foreign_key: :facility_id, inverse_of: :teachers, required: false

end
