class CardIp
  include ModelBase
  field :operation, type: String, default: 'add' #:delete, add
  field :status, type: String, default: 'running'  #running, success, fail
  field :access_ip, type: String, default: ''
  field :access_no, type: String, default: '' #ic_card
  field :user_facility_ids, type: Array, default: []
  field :user_org_ids, type: Array, default: []
  field :errno, type: String, default: ''
  belongs_to :user
  belongs_to :house

  def self.factory(attrs)
    house = attrs[:house] if attrs[:house].present?
    house ||= House.where(id: attrs[:house_id]).first if attrs[:house_id].present?

    user = attrs[:user] if attrs[:user].present?
    user ||= User.where(id: attrs[:user_id]).first if attrs[:user_id].present?
    user ||= Student.where(sno: attrs[:user_sno]).first if attrs[:user_sno].present?

    if house && user && attrs[:operation].present?
      return house.face_accesses.map do |access|
        if access.ip.present?
          opts = {
              house: house,
              user: user,
              operation: attrs[:operation],
              access_ip: access.ip,
              access_no: attrs[:access_no] || user.ic_card
          }.delete_if {|k, v| v.blank?}
          self.create(opts)
        end
      end
    end
    false
  end

  set_callback(:save, :before) do |doc|
    doc.user_facility_ids = doc.user.facility_ids
    doc.user_org_ids = doc.user.org_ids
  end
end