namespace :bxt do
  desc "init menu"
  task :menu => :environment do
    MenuItem.create title: '组织管理', icon: 'business' do |m|
      m.children.build title: '学院管理', path: 'colleges'
      m.children.build title: '系部管理', path: 'departments'
      m.children.build title: '学年管理', path: 'grades'
      m.children.build title: '班级管理', path: 'classrooms'
    end
    MenuItem.create title: '公寓管理', icon: 'location_city' do |m|
      m.children.build title: '楼栋管理', path: 'houses'
      m.children.build title: '楼层管理', path: 'floors'
      m.children.build title: '房间管理', path: 'rooms'
      m.children.build title: '床位管理', path: 'beds'
    end
    MenuItem.create title: '人员管理', icon: 'people' do |m|
      m.children.build title: '学生管理', path: 'students'
    end
  end
end
