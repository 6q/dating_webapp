require 'csv'

module CreateCities
  def self.create_all limit = nil
    require_relative '../config/environment'
    CSV.foreach("#{Rails.root}/db/data/worldcitiespop.txt", encoding: 'utf-8', quote_char: "\0") do |l|
      c = City.create!(country: l[0], name: l[2], region: l[3], latitude: l[5], longitude: l[6])
      puts c
    end
  end
end
