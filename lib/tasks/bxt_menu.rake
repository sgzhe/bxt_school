namespace :bxt do
  desc "init menu"
  task :menu => :environment do
    MenuItem.create title: '学生管理' do |m|
      m.children.build title: '学院管理', path: 'colleges'
      m.children.build title: '系部管理', path: 'departments'
      m.children.build title: '学年管理', path: 'grades'
      m.children.build title: '班级管理', path: 'classrooms'
      m.children.build title: '学生管理', path: 'students'
    end
    MenuItem.create title: '公寓管理' do |m|
      m.children.build title: '楼栋管理', path: 'houses'
      m.children.build title: '楼层管理', path: 'floors'
    end
  end
end
