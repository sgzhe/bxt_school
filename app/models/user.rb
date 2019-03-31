require 'bcrypt'
class User
  include ModelBase
  include ActiveModel::SecurePassword

  field :name
  field :gender_mark, default: :male
  field :id_card
  field :ic_card
  field :tel
  field :avatar
  field :login
  field :password_digest

  field :pass_time_at_last, type: DateTime
  field :status_at_last
  field :direction_at_last
  field :overtime_at_last, type: Integer, default: 0

  belongs_to :access_at_last, class_name: 'Access', foreign_key: :access_id, required: false
  has_and_belongs_to_many :roles, class_name: 'Role', inverse_of: nil
  has_and_belongs_to_many :groups, class_name: 'Group', inverse_of: nil
  has_many :trackers

  #default_scope -> { order_by(id: -1) }

  def pass(access, direction, pass_time = DateTime.now)
    last = ((pass_time_at_last || pass_time).at_beginning_of_day + access.closing_at.minutes).to_datetime
    is_timeout = pass_time > last
    timeout = ((pass_time - last).to_f * 24).to_i
    timeout = is_timeout ? timeout : 0
    if direction == :in
      state = :back
      state = :back_late if is_timeout
    else
      state = :outgoing
      state = :night_out if is_timeout
    end

    self.status_at_last = state
    self.pass_time_at_last = pass_time
    self.direction_at_last = direction
    self.overtime_at_last = timeout
    self.access_at_last = access
    self.save

    Tracker.create(user: self, pass_time: pass_time, access: access, direction: direction, status: state, overtime: timeout)

    if is_timeout
      comer = Latecomer.find_or_initialize_by(user: self, day: pass_time.to_date)
      comer.status = state
      comer.overtime = timeout
      comer.pass_time = pass_time
      comer.save
    end
  end

  def reside
    return 0 if pass_time_at_last.nil?
    (DateTime.now - pass_time_at_last).to_i
  end

  def aros
    aro_set = roles
    groups.each do |g|
      aro_set += g
      aro_set += g.roles
    end
    aro_set
  end

  has_secure_password

  set_callback(:initialize, :before) do |doc|
    doc.password = 'bxt-123' if :new_record?
  end

end