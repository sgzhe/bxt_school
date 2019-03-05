class Dict
  include ModelBase

  field :name
  field :title

  embeds_many :dict_items

  class << self
    def items(dict_name)
      where(name: dict_name).first.try(:dict_items) || []
    end

    def item(dict_name, item_name)
      items(dict_name).detect { |item| item.name.to_s == item_name.to_s }
    end

    def title(dict_name, item_name)
      item(dict_name, item_name).try(:title)
    end
  end

end
