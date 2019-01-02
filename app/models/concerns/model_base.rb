module ModelBase
  extend ActiveSupport::Concern

  included do
    include Mongoid::Document
    include Mongoid::Timestamps

    field :actived, type: Boolean, default: true
    field :datatype, type: Symbol, default: :app #:sys, :app
    field :seq, type: Integer, default: 0
    field :desc
  end
end