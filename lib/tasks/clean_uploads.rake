namespace :uploads do
  desc 'Clean up non assigned registration images'
  task clean: :environment do
    Picture.where(attachable_id: nil).each { |p| p.destroy }
  end
end
