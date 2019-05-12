namespace :hk_avatar do
  desc 'update avatar'
  task data: :environment do
    Student.all.each do |u|
      p id = u.img.split('id=')[1] unless u.img.blank?
      p u.update_attribute(:img2, id + ".jpg") if id

      p u
    end
  end
end
