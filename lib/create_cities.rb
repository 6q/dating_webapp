require 'csv'

module CreateCities
  def self.create_all limit = nil
    require_relative '../config/environment'
    CSV.foreach("#{Rails.root}/db/seeds/geo/regions.csv") do |l|
      c = Region.create!(country: l[0], code: l[1], name: l[2])
      puts c
      
      #base_dir = "#{RAILS_ROOT}/db/data"

      #bulk_load = [Book, Chapter, Verse]

      #bulk_load.each do |table|
      #  if table.first.nil? # only bulk load into empty tables
      #    f = File.new "#{base_dir}/#{table.table_name}.sql"

      #    while statements = f.gets("") do
      #      ActiveRecord::Base.connection.execute(statements)
      #    end
      #  end
      #end
    
    
    end
  end
end
