class Latecomer
  include Mongoid::Document

  field :day, type: Date
  field :pass_time, type: DateTime
  field :status
  field :overtime, type: Integer, default: 0
  field :overtime_cause

  field :user_name
  field :user_sno
  field :dept_title
  field :dorm_title
  field :org_ids, type: Array, :default => []
  field :facility_ids, type: Array, :default => []

  belongs_to :user

  default_scope -> { order_by(pass_time: -1) }

  set_callback(:save, :before) do |doc|
    doc.user_name = doc.user.name
    doc.user_sno = doc.user.sno
    doc.dept_title = doc.user.dept_title
    doc.dorm_title = doc.user.dorm_title
    doc.org_ids = doc.user.org_ids
    doc.facility_ids = doc.user.facility_ids
  end

end