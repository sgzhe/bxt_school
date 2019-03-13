class Grade
  include Mongoid::Document

  field :mark
  field :title
  field :desc

  embedded_in :department
end