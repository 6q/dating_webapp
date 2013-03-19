require 'csv'

module CreateTowns
  def self.create_all limit = nil
    require_relative '../config/environment'
    lines = CSV.open("#{Rails.root}/db/seeds/geo/spain_towns2.csv").readlines
    keys = lines.delete lines.first

    data = lines.map do |values|
      Hash[keys.zip(values)]
    end

    data = data.group_by do |el|
      el['region']
    end.map do |k,v|
      [k,v.group_by do |v1|
        v1['province']
      end]
    end
    data = Hash[data]

    count = 0
    data.each do |k,v|
      r = Region.create!({:name => k}, without_protection: true)
      v.each do |k1,v1|
        p = Province.create!({:name => k1, :region_id => r.id}, without_protection: true)
        v1.each do |v2|
          count += 1
          break if limit && count > limit
          Town.create!({:name => v2['town'], :region_id => r.id, :province_id => p.id, :latitude => v2['latitude'].to_f, :longitude => v2['longitude'].to_f}, without_protection: true)
        end
      end
    end
  end

end
