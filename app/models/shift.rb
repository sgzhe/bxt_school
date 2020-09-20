class Shift
  include ModelBase

  field :title, type: String, default: ''
  field :on_duty, type: String, default: ''
  field :off_duty, type: String, default: ''
end
