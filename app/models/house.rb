class House < Facility
  field :closing_at, type: Float, default: 0.0

  has_many :floors, class_name: 'Floor', foreign_key: :parent_id, inverse_of: :house, validate: false, dependent: :restrict_with_exception
  has_many :card_accesses, class_name: 'CardAccess', foreign_key: :parent_id, inverse_of: :house, validate: false, dependent: :restrict_with_exception
  has_many :accesses, class_name: 'Access', foreign_key: :parent_id, inverse_of: :house, validate: false, dependent: :restrict_with_exception

  def access_ips
    ips = {}
    self.accesses.map do |acc|
      ips[acc.ip.tr('.', '-')] = 0 unless acc.ip.blank?
    end
    ips
  end

  def card_access_ips
    ips = {}
    self.card_accesses.map do |acc|
      ips["#{acc.ip.tr('.', '-')}@#{acc.mark}"] = 0 unless acc.ip.blank?
    end
    ips
  end
end
