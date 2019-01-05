namespace :bxt do
  desc "init menu"
  task :menu => :environment do
    MenuItem.create title: '学生管理' do |m|
      m.children.build title: '学院管理'
      m.children.build title: '系部管理'
      m.children.build title: '学年管理'
      m.children.build title: '学生管理'
    end
    MenuItem.create title: '公寓管理' do |m|
      m.children.build title: '楼栋管理'
      m.children.build title: '楼层管理'
    end
  end
end
