class ImportAvatar
  include ActiveModel::Model
  attr_reader :data

  def initialize(opts = {})

  end

  def save
    true
  end
end