namespace :products do
  desc "Generate N random products immediately (default 1000)"
  task :generate, [:count] => :environment do |_, args|
    count = (args[:count] || 1000).to_i
    GenerateRandomProductsJob.perform_now(count)
    puts "Generated #{count} random products"
  end
end