class Student < User

  def dept_title
    "#{college&.title}>>#{department&.title}>>#{classroom&.title}"
  end

end
