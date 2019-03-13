namespace :bxt do
  desc 'init dict data'
  task dict: :environment do

    Dict.create name: 'privilege_type', title: '权限类型' do |d|
      d.dict_items.build(name: 'view', title: '浏览')
      d.dict_items.build(name: 'edit', title: '编辑')
    end

    Dict.create name: 'gender_type', title: '性别类型' do |d|
      d.dict_items.build(name: 'male', title: '男')
      d.dict_items.build(name: 'female', title: '女')
    end

  end
end