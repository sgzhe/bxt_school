class ImportAvatar
  include ActiveModel::Model
  attr_reader :data

  def initialize(import_avatar)
    @user = Student.find_by(sno: 'S318107024')
    @user.avatar = import_avatar
    @data = { original_filename: import_avatar.original_filename }
  end

  def save
    @user.save
    @data[:avatar_url] = @user.avatar.url
  end

end