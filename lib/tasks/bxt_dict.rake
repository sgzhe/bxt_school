namespace :bxt do
  desc 'init dict data'
  task dict: :environment do

    Dict.create mark: 'privilege_type', title: '权限类型' do |d|
      d.dict_items.build(mark: 'view', title: '浏览')
      d.dict_items.build(mark: 'edit', title: '编辑')
    end

    Dict.create mark: 'gender_type', title: '性别类型' do |d|
      d.dict_items.build(mark: 'male', title: '男')
      d.dict_items.build(mark: 'female', title: '女')
    end

    Dict.create mark: 'sleep_status', title: '状态' do |d|
      d.dict_items.build(mark: 'back_late', title: '晚归')
      d.dict_items.build(mark: 'night_out', title: '夜出')
      d.dict_items.build(mark: 'go_out', title: '未归')
      d.dict_items.build(mark: 'back', title: '已归')
    end

  end
end