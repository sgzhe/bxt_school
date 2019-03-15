class Student < User

  belongs_to :classroom, class_name: 'Classroom', foreign_key: :org_id, inverse_of: :students, required: false
  belongs_to :room, class_name: 'Room', foreign_key: :facility_id, inverse_of: :students, required: false

  def department
    parent_org(classroom.parent_id)
  end

  def college
    parent_org(department.parent_id)
  end

  def house
    parent_facility(room.parent_id)
  end

end
