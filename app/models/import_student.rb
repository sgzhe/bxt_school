class ImportStudent
  include ActiveModel::Model
  attr_reader :data
  def initialize(opts = {})
    p @data = opts
    #@header = @data.shift if @data.size > 0
  end

  def save
    #@data.each do |d|
       #p d.at(@header.index("学号"))
      # p d.at(@header.index("寝室号")).to_s[0,1]
       #p h = House.find_or_initialize_by(mark: d.at(@header.index("公寓号")).to_s)
      # f = Floor.find_or_initialize_by(title: d.at(@header.index("寝室号")), mark: d.at(@header.index("寝室号")), parent_id: h.id)
       #f.save if f.new_record?
       #r = Room.find_or_initialize_by(title: @header.index("寝室号"), mark: @header.index("寝室号"), parent_id: f.id)
       #r.save if r.new_record?
       #s = Student.find_or_initialize_by(sno: d.at(@header.index("学号")))
    #end
    true
  end



end