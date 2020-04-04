class CardAccess < Facility

  field :closing_at, type: Integer, default: 1410
  field :opening_at, type: Integer, default: 240
  field :ip
  field :direction, type: Symbol, default: :in #:in :out
  field :status
  field :mark

  belongs_to :house, class_name: 'House', foreign_key: :parent_id, inverse_of: :floors, required: false


end
