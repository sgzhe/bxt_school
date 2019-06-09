namespace :bxt do
  desc 'init system data'
  task init: :environment do
    group = Group.create(title: '校组')
    role1 = Role.create(title: '超管', mark: 'sys_admin', datatype: :sys)
    role2 = Role.create(title: '校管', groups: [group])
    manager = Manager.create(name: "超级管理员", login: 'super', password: 'bxt-super', roles: [role1], datatype: :sys)
    manager = Manager.create(name: "校级管理员", login: 'admin', password: 'bxt-admin', roles: [role2])
  end
end
