class Dict
  include ModelBase

  field :mark
  field :title

  embeds_many :dict_items

  class << self
    def items(dict_mark)
      where(mark: dict_mark).first.try(:dict_items) || []
    end

    def item(dict_mark, item_mark)
      items(dict_mark).detect { |item| item.mark.to_s == item_mark.to_s }
    end

    def title(dict_mark, item_mark)
      item(dict_mark, item_mark).try(:title)
    end
  end

end
