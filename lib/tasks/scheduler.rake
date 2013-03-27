desc "This task is called by the Heroku scheduler add-on"
task :update_pub_cat_namelist => :environment do
  puts "Updating pub_cat_namelist..."
  PubCatNamelist.cron_update_pub_cat_namelist
  puts "done."
end

task :update_pub_cat_namelist => :environment do
  puts "Updating pub_cat_aggregates..."
  PubCatAggregate.cron_update_pub_cat_aggregates
  puts "done."
end