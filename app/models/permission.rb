class Permission
  include ModelBase

  field :operations, type: Array, default: []

  belongs_to :aro, class_name: 'Aro'
  belongs_to :aco, polymorphic: true

  def permit(operation)
    operations.any? { |op| op.to_s == operation.to_s }
  end

  class << self
    def permit(aro_id, aco_id, operation)
      @permissions ||= all.to_a
      perm = @permissions.detect { |pe| pe.aro_id.to_s == aro_id.to_s && pe.aco_id.to_s == aco_id.to_s }
      perm &. permit(operation)
    end

    def load
      @permissions = all.to_a
    end
  end


end
