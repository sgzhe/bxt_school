class Aro
  include ModelBase

  field :title, type: String, default: ''
  field :mark, type: String, default: ''

  scope :app, -> { where(datatype: :app) }

  def allow?(aco_id, operation)
    Permission.permit(self.id, aco_id, operation)
  end

end