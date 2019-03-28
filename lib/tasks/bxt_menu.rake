namespace :bxt do
  desc 'init menu data'
  task menu: :environment do
    MenuItem.create title: '组织管理', icon: 'bubble_chart' do |m|
      m.children.build title: '学院管理', path: 'colleges'
      m.children.build title: '系部管理', path: 'departments'
      m.children.build title: '班级管理', path: 'classrooms'
    end
    MenuItem.create title: '设施管理', icon: 'location_city' do |m|
      m.children.build title: '楼栋管理', path: 'houses'
      m.children.build title: '房间管理', path: 'rooms'
    end
    MenuItem.create title: '人员管理', icon: 'people' do |m|
      m.children.build title: '学生管理', path: 'students'
      m.children.build title: '教师管理', path: 'teachers'
      m.children.build title: '管理员', path: 'managers'
    end
    MenuItem.create title: '公寓管理', icon: 'track_changes' do |m|
      m.children.build title: '入住管理', path: 'accommodations'
      m.children.build title: '晚归记录', path: 'latecomers'
      m.children.build title: '出入记录', path: 'traces'
      m.children.build title: '归寝管理', path: 'trackers'
      m.children.build title: '宿管考勤', path: 'attendances'
    end
    MenuItem.create title: '设备管理', icon: 'settings_remote' do |m|
      m.children.build title: '门禁管理', path: 'access'
      m.children.build title: '摄像机管理', path: 'webcams'
      m.children.build title: '闸机管理', path: 'gates'
      m.children.build title: '闸机日志', path: 'gate-logs'
    end
    MenuItem.create title: '系统管理', icon: 'settings' do |m|
      m.children.build title: '菜单管理', path: 'menu_items'
      m.children.build title: '字典管理', path: 'dicts'
      m.children.build title: '角色管理', path: 'roles'
      m.children.build title: '用户组管理', path: 'groups'
    end
  end
end
