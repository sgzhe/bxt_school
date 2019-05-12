class Student < User
  field :grade
  field :entranced_at, type: Date
  def dept_title
    "#{dept.parent.parent&.title}>>#{dept.parent&.title}>>#{dept&.title}"
  end

end
