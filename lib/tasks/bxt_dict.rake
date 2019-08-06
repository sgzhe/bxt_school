namespace :bxt do
  desc 'init dict data'
  task dict: :environment do
    Dict.all.delete_all

    Dict.create mark: 'menu_privilege', title: '菜单权限' do |d|
      d.dict_items.build(mark: 'view', title: '浏览')
      d.dict_items.build(mark: 'edit', title: '编辑')
    end

    Dict.create mark: 'house_privilege', title: '公寓权限' do |d|
      d.dict_items.build(mark: 'view', title: '浏览')
      d.dict_items.build(mark: 'edit', title: '编辑')
    end

    Dict.create mark: 'gender_type', title: '性别类型' do |d|
      d.dict_items.build(mark: 'male', title: '男')
      d.dict_items.build(mark: 'female', title: '女')
    end

    Dict.create mark: 'direction_type', title: '方向类型' do |d|
      d.dict_items.build(mark: 'in', title: '入寝')
      d.dict_items.build(mark: 'out', title: '出寝')
    end

    Dict.create mark: 'sleep_status', title: '异常状态' do |d|
      d.dict_items.build(mark: 'back_late', title: '晚归', color: 'navy')
      d.dict_items.build(mark: 'go_out', title: '未归', color: 'peru')
      d.dict_items.build(mark: 'days_in', title: '多日未出', color: 'red')
      d.dict_items.build(mark: 'days_out', title: '多日未归', color: 'purple')
      d.dict_items.build(mark: 'normal', title: '正常', color: '')
    end

    Dict.create mark: 'dorm_type', title: '寝室类型' do |d|
      d.dict_items.build(mark: 'men', title: '男寝', color: 'blue')
      d.dict_items.build(mark: 'women', title: '女寝', color: 'red')
    end

    Dict.create mark: 'dorm_toward', title: '寝室方向' do |d|
      d.dict_items.build(mark: 'east', title: '东')
      d.dict_items.build(mark: 'south', title: '南')
      d.dict_items.build(mark: 'west', title: '西')
      d.dict_items.build(mark: 'north', title: '北')
    end



  end
end