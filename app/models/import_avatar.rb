class ImportAvatar
  include ActiveModel::Model
  attr_reader :data

  def initialize(import_avatar)
    sno = import_avatar.original_filename.split('.')[0]
    @user = Student.where(sno: sno).first
    @user.avatar = import_avatar if @user
    @data = { original_filename: import_avatar.original_filename }
  end

  def save
    if @user
      @data[:avatar_url] = @user.avatar.url
      return @user.save
    end
    false
  end

end