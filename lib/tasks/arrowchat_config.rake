namespace :arrowchat do
  desc 'Load default arrowchat options'
  task config: :environment do
    base_dir = Rails.root.join('db', 'data')
    f = File.new "#{base_dir}/arrowchat_config.sql"

    while statements = f.gets("") do
      ActiveRecord::Base.connection.execute(statements)
    end
  end
end
task
