desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  require 'social_feeds_updater'

  puts "Updating social feeds ..."
  SocialFeedsUpdater.update
  puts "done"
end
