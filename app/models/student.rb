class Student < User

  def dept_title
    "#{dept.parent.parent&.title}>>#{dept.parent&.title}>>#{dept&.title}"
  end

end
