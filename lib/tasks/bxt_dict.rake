namespace :bxt do
  desc 'init dict data'
  task dict: :environment do

    Dict.create name: 'grade_level', title: '年级级别' do |d|
      d.dict_items.build(name: '01', title: '大一')
      d.dict_items.build(name: '02', title: '大二')
      d.dict_items.build(name: '03', title: '大三')
      d.dict_items.build(name: '04', title: '大四')
      d.dict_items.build(name: '05', title: '大五')
    end

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