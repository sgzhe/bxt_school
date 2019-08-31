namespace :bxt do
  desc 'init menu data'
  task menu: :environment do

    MenuItem.all.delete
    MenuItem.create title: '组织管理', icon: 'bubble_chart' do |m|
      m.children.build title: '院系管理', path: 'colleges'
      m.children.build title: '专业管理', path: 'departments'
      m.children.build title: '班级管理', path: 'classrooms'
    end
    MenuItem.create title: '设施管理', icon: 'location_city' do |m|
      m.children.build title: '楼栋管理', path: 'houses'
      m.children.build title: '楼层管理', path: 'floors'
      m.children.build title: '房间管理', path: 'rooms'
    end
    MenuItem.create title: '人员管理', icon: 'people' do |m|
      m.children.build title: '学生管理', path: 'students'
      m.children.build title: '教师管理', path: 'teachers'
      m.children.build title: '管理员', path: 'managers'
    end
    MenuItem.create title: '公寓管理', icon: 'track_changes' do |m|
      m.children.build title: '仪表盘', path: 'dashboards'
      m.children.build title: '住宿统计', path: 'accommodations'
      m.children.build title: '归寝统计', path: 'homings'
      m.children.build title: '出入预警', path: 'incomings'
      m.children.build title: '异常记录', path: 'latecomers'
      m.children.build title: '门禁记录', path: 'trackers'

      m.children.build title: '宿管考勤', path: 'attendances'
      m.children.build title: '调寝管理', path: 'exchanges'
    end
    MenuItem.create title: '设备管理', icon: 'settings_remote' do |m|
      m.children.build title: '人脸门禁', path: 'accesses'
      m.children.build title: '闸机管理', path: 'gates'
      m.children.build title: '摄像机管理', path: 'webcams'
      m.children.build title: '录像机管理', path: 'video-recorders'
      m.children.build title: '闸机日志', path: 'gate-logs'
    end
    MenuItem.create title: '系统管理', icon: 'settings' do |m|
      m.children.build title: '菜单管理', path: 'menu_items'
      m.children.build title: '字典管理', path: 'dicts'
      m.children.build title: '角色管理', path: 'roles'
      m.children.build title: '用户组管理', path: 'groups'
      m.children.build title: '菜单权限', path: 'menu-accesses'
      m.children.build title: '公寓权限', path: 'house-accesses'
      m.children.build title: '假期管理', path: 'holidays'
    end
  end

end
