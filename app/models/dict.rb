class Dict
  include ModelBase

  field :name
  field :title

  embeds_many :dict_item
end
