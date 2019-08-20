namespace :hk_avatar do
  desc 'update avatar'
  task data: :environment do
    Student.all.each do |u|
      p id = u.img.split('id=')[1] unless u.img.blank?
      p u.update_attribute(:img2, id + ".jpg") if id

      p u
    end
  end

  task face_id: :environment do
    Student.all.each do |u|
      p u.face_id
      p u.update_attribute(:face_id, u.face_id.to_i)


    end
  end

  task pre_back: :environment do
    Student.all.each do |u|
      p u.pass_time_at_last
      p u.update_attribute(:pre_back_at_last, u.pass_time_at_last.at_beginning_of_day + 1770.minutes)

    end
  end

  task avatar13: :environment do
    Student.where(facility_ids: BSON::ObjectId('5cc6c65588dba063c404a78d')).each do |s|
      img = s.img.split('.')[0] + '.jpg.thumbnail.jpg'
      source = 'F:/Projects/bxt_school/public/uploads/student/avatar2019/'
      dest = 'F:/Projects/a13/' + img
      p jpg = source + img
      FileUtils.cp(jpg, dest) if File.exists?(jpg)

    end

  end
end
