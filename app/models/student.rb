class Student < User

  belongs_to :classroom, class_name: 'Classroom'
  belongs_to :bed, class_name: 'Bed'

end
