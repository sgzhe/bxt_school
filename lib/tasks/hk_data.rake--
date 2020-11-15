require 'pg'
namespace :hk_data do
  desc 'import data'
  task import: :environment do
    houses1 = [{building_code: '18', building_name: '外专留学生公寓'},
               {building_code: '3', building_name: '三公寓'},
               {building_code: '10', building_name: '十公寓'},
               {building_code: '6', building_name: '六公寓'},
               {building_code: '9', building_name: '九公寓'},
               {building_code: '13', building_name: '十三公寓'},
               {building_code: '15', building_name: '十五公寓'},
               {building_code: '2', building_name: '二公寓'}]

    con = PG.connect host: "192.168.0.67", user: "postgres", password: "Hik12345", dbname: "dcms", port: "5432"

    houses1.each do |row|
      h = House.create(title: row[:building_name], mark: row[:building_code])
      rs1 = con.exec "SELECT DISTINCT floor_no FROM edu_dorm where building_code='#{row[:building_code]}' ORDER BY floor_no"
      rs1.each do |row1|
        f = Floor.create(title: row1['floor_no'], mark: row1['floor_no'], parent_id: h.id)
        rs2 = con.exec "SELECT DISTINCT room_no FROM edu_dorm where building_code='#{row[:building_code]}' and floor_no='#{row1['floor_no']}' ORDER BY room_no"
        rs2.each do |row2|
          r = Room.new(title: row2['room_no'], mark: row2['room_no'], parent_id: f.id)
          rs3 = con.exec "SELECT DISTINCT bed_no FROM edu_dorm where building_code='#{row[:building_code]}' and floor_no='#{row1['floor_no']}' and room_no='#{row2['room_no']}' ORDER BY bed_no"
          rs3.each do |row3|
            r.beds.build(mark: row3['bed_no'])
          end
          r.save
        end
      end
    end

  end

  desc 'import data'
  task student: :environment do
    con = PG.connect host: "192.168.0.67", user: "postgres", password: "Hik12345", dbname: "dcms", port: "5432"
    rs1 = con.exec "SELECT edu_person.person_name,edu_person.person_code, edu_person.gendar, edu_person.photourl, edu_dorm.building_code, edu_dorm.room_no, edu_dorm.bed_no FROM edu_person JOIN edu_dorm ON edu_person.person_code = edu_dorm.person_code"
    rs1.each do |row1|
      h = House.find_by(mark: row1['building_code'])
      r = Room.find_by(title: row1['room_no'], parent_ids: h.id)
      s = Student.create(name: row1['person_name'], gender_mark: row1['gendar'] == '1' ? :male : :female, sno: row1['person_code'], dorm: r, bed_mark: row1['bed_no'], img: row1['photourl'])
      p s
      p r.beds
      b = r.beds.detect {|b| b.mark.to_s == row1['bed_no'].to_s}
      b.owner = s
      s.save
    end

  end

  task uid: :environment do
    con = PG.connect host: "10.200.2.251", user: "postgres", password: "Hik12345", dbname: "icms", port: "5432"
    rs1 = con.exec "SELECT * From person_info"
    rs1.each do |row1|
      s = Student.where(sno: row1['person_code']).first      
      if s
        p s.face_id = row1['uid']
        #s.save
      end      
    end
  end

  task uid11: :environment do
    con = PG.connect host: "127.0.0.1", user: "postgres", password: "Hik12345", dbname: "bxt_tmp", port: "5432"
    rs1 = con.exec "SELECT * From person_info"
    rs1.each do |row1|
      s = Student.find_or_initialize_by(sno: row1['person_code'])
      s.name = row1['name']
      p "#{s.face_id} = #{row1['uid']}"
      s.face_id = row1['uid']
      p s.img3 = 'faced_add' if s.new_record?
      s.save
    end
  end

  task uid22: :environment do
    con = PG.connect host: "127.0.0.1", user: "postgres", password: "Hik12345", dbname: "bxt_tmp", port: "5432"
    rs1 = con.exec "SELECT * From person_info"
    
    rs1.each do |row1|
      rs2 = con.exec "SELECT edu_person.person_name,edu_person.person_code, edu_person.gendar, edu_person.photourl, edu_dorm.building_code, edu_dorm.floor_no, edu_dorm.room_no, edu_dorm.bed_no FROM edu_person JOIN edu_dorm ON edu_person.person_code = edu_dorm.person_code where edu_person.person_code='#{row1['person_code']}'" 
      if rs2
        row2 = rs2[0]
        h = House.find_by(mark: row2['building_code'])
        f = Floor.find_or_initialize_by(title: row2['floor_no'], mark: row2['floor_no'], parent_id: h.id)
        f.save if f.new_record?
        r = Room.find_or_initialize_by(title: row2['room_no'], mark: row2['room_no'], parent_id: f.id)
        r.save if r.new_record?
        s = Student.find_or_initialize_by(sno: row2['person_code'])
        if s
          b = r.beds.detect {|b| b.mark.to_s == row2['bed_no'].to_s}
          b = r.beds.build(mark: row2['bed_no']) unless b
          b.owner = s
          b.save
          # s.avatar = s.img
          # s.save
          # s.name = row2['person_name']
          # s.gender_mark = row2['gendar'] == '1' ? :male : :female
          # s.sno = row2['person_code']
          # s.dorm = r
          # s.bed_mark = row2['bed_no']
          # id = row2['photourl'].split('id=')[1]
          # s.img = id + '.jpg'  if id
          # s.face_id = row1['uid']
          # s.save if s.new_record?       
          p s.name
        end  
      end
    end
  end

end
