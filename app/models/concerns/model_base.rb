module ModelBase
  extend ActiveSupport::Concern

  included do
    include Mongoid::Document
    include Mongoid::Timestamps

    field :activated, type: Boolean, default: true
    field :datatype, type: Symbol, default: :app #:sys, :app
    field :seq, type: Integer, default: 0
    field :desc, type: String, default: ''

    default_scope -> { where(activated: true) }

    alias :orgin_destroy :destroy

    def destroy
      update(activated: false)
    end
  end
end