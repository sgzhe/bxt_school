namespace :bxt do
  desc 'init dict data'
  task dict: :environment do

    Dict.create name: 'grade', title: '年级' do |d|
      d.dict_items.build(name: '01', title: '大一')
      d.dict_items.build(name: '02', title: '大二')
      d.dict_items.build(name: '03', title: '大三')
      d.dict_items.build(name: '04', title: '大四')
      d.dict_items.build(name: '05', title: '大五')
    end

  end
end