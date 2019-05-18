require 'roo'
namespace :hgc do
  desc 'import data'
  task data: :environment do
    xlsx = Roo::Spreadsheet.open(Rails.root.join('db', 'hgc.xlsx').to_s)
    p xlsx.info
    sno = ''
    xlsx.each_with_pagename  do |name, sheet|
      begin
        sheet.drop(1).each do |row|
          c = College.find_or_initialize_by(title: row[3])
          c.save
          d = Department.find_or_initialize_by(title: row[4], parent_id: c.id)
          d.save
          sno = row[1]
          s = Student.find_by(sno: sno)
          if s
            s.dept_id = d.id
            s.grade = row[0]
            s.entranced_at = Date.parse(row[8].to_s.ljust(8, '01'))
            s.ic_card = row[10].to_s.rjust(10, '0')
            s.ic_card2 = row[9]
            s.save
          end
        end
      rescue
        p sno
      end
    end
  end

  task bed: :environment do
    Student.all.each do |u|
      unless u.bed_mark.blank?
        b = u.dorm.beds.detect { |d| d.mark == u.bed_mark }
        if b
          b.owner = u
          begin
            u.dorm.save
          rescue
            p u
          end
        end
      end
    end
  end
end
