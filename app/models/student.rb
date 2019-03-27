class Student < User

  field :sno, type: String
  field :house_title, type: String
  field :room_title, type: String
  field :bed_title, type: String
  field :college_title, type: String
  field :department_title, type: String
  field :classroom_title, type: String

  belongs_to :house, required: false
  belongs_to :room, class_name: 'Room', required: false
  belongs_to :college, required: false
  belongs_to :department, required: false
  belongs_to :classroom, class_name: 'Classroom', required: false

  set_callback(:save, :before) do |doc|
    unless doc.room.nil?
      doc.room_title = doc.room.title
      doc.house = doc.room.house
      doc.house_title = doc.room.house.title
    end
    unless doc.classroom.nil?
      doc.classroom_title = doc.classroom.title
      doc.department = doc.classroom.department
      doc.department_title = doc.classroom.department.title
      doc.college = doc.classroom.department.college
      doc.college_title = doc.classroom.department.college.title
    end
  end

end
