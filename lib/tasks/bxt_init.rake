namespace :bxt do
  desc 'init system data'
  task init: :environment do
    Role.all.delete
    Manager.all.delete
    #oup = Group.create(title: '校组')
    role1 = Role.create(title: '超管', mark: 'sys_admin', datatype: :sys)
    role2 = Role.create(title: '学校管理员')
    role3 = Role.create(title: '公寓管理员')
    manager = Manager.create(name: "系统超管", login: 'super', password: 'bxt-super', roles: [role1], datatype: :sys)
    manager = Manager.create(name: "学校超管", login: 'admin', password: 'bxt-admin', roles: [role2])
  end
end
