class Latecomer
  include Mongoid::Document

  field :day, type: Date
  field :pass_time, type: DateTime
  field :status
  field :overtime, type: Integer, default: 0
  field :overtime_cause

  field :user_name
  field :user_sno
  field :user_dept_title
  field :user_dorm_title
  field :user_org_ids, type: Array, :default => []
  field :user_facility_ids, type: Array, :default => []
  field :facility_ids, type: Array, default: []

  belongs_to :user

  default_scope -> { order_by(pass_time: -1) }

  set_callback(:save, :before) do |doc|
    doc.user_name = doc.user.name
    doc.user_sno = doc.user.sno
    doc.user_dept_title = doc.user.dept_full_title
    doc.user_dorm_title = doc.user.dorm_full_title
    doc.user_org_ids = doc.user.org_ids
    doc.user_facility_ids = doc.user.facility_ids
  end

end