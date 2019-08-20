class ImportStudent
  include ActiveModel::Model

  def initialize(opts = {})
     p opts[:result]
  end

  def save
    true
  end

end