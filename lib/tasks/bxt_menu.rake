namespace :bxt do
  desc 'init menu data'
  task menu: :environment do
    MenuItem.create title: '组织管理', icon: 'business' do |m|
      m.children.build title: '学院管理', path: 'colleges'
      m.children.build title: '系部管理', path: 'departments'
      m.children.build title: '班级管理', path: 'classrooms'
    end
    MenuItem.create title: '公寓管理', icon: 'location_city' do |m|
      m.children.build title: '楼栋管理', path: 'houses'
      m.children.build title: '房间管理', path: 'rooms'
      m.children.build title: '床位管理', path: 'beds'
    end
    MenuItem.create title: '人员管理', icon: 'people' do |m|
      m.children.build title: '学生管理', path: 'students'
      m.children.build title: '教师管理', path: 'teachers'
      m.children.build title: '管理员', path: 'managers'
    end
    MenuItem.create title: '安全管理', icon: 'track_changes' do |m|
      m.children.build title: '门禁管理', path: 'trackers'
    end
    MenuItem.create title: '系统管理', icon: 'settings' do |m|
      m.children.build title: '菜单管理', path: 'menu_items'
      m.children.build title: '字典管理', path: 'dicts'
      m.children.build title: '角色管理', path: 'roles'
      m.children.build title: '用户组管理', path: 'groups'
    end
  end
end
