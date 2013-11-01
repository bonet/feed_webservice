desc "This task is called by the Heroku scheduler add-on"
task :update_categories_per_publisher => :environment do
  puts "Updating categories_per_publisher..."
  CategoriesPerPublisher.cron_update_categories_per_publisher
  puts "done."
end

task :update_newsfeed_aggregates => :environment do
  puts "Updating newsfeed_aggregates..."
  NewsfeedAggregate.cron_update_newsfeed_aggregates
  puts "done."
end