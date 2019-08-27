class ImportStudent
  include ActiveModel::Model
  attr_reader :data

  def initialize(opts = {})
    @data = opts
  end

  def save
    h = House.find_or_initialize_by(mark: @data[:house].to_s)
    if h.new_record?
      h.title = "#{@data[:house]}公寓"
      h.save
    end
    f = Floor.find_or_initialize_by(mark: @data[:dorm].to_s[0..-3], parent_id: h.id)
    if f.new_record?
      f.title = @data[:dorm].to_s[0..-3]
      f.save
    end
    r = Room.find_or_initialize_by(mark: @data[:dorm].to_s, parent_id: f.id)
    if r.new_record?
      r.rating_num = @data[:rating_num]
      r.title = @data[:dorm].to_s
      r.save
    end
    c = College.find_or_initialize_by(title: @data[:college])
    c.save if c.new_record?
    d = Department.find_or_initialize_by(title: @data[:department], parent_id: c.id)
    d.save if d.new_record?
    s = Student.find_or_initialize_by(sno: @data[:sno].to_s)
    b = r.beds.detect { |b| b.mark.to_s == @data[:bed].to_s }
    b ||= r.beds.build(mark: @data[:bed])
    b.owner = s
    b.save
    s.name = @data[:name]
    s.gender_mark = @data[:gender] == '男' ? :male : :female
    s.sno = @data[:sno]
    s.dorm = r
    s.bed_mark = @data[:bed]
    s.tel = @data[:telephone]
    s.nation = @data[:nation]
    s.birthday = @data[:birthday]
    s.hometown = @data[:hometown]
    s.cls_group = @data[:cls_group]
    s.dept = d
    s.save
  end



end