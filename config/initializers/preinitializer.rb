require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new

# import feeds for all the old users
last_updated=Time.zone.now.utc
p "config/preinitializer.rb - Setting up Rufus scheduler to import facebook feeds every 20 minutes, with the first one in 20 seconds"
scheduler.every "20m", :first_in => '20s' do 
  #this if block avoids problems with putting my laptop to sleep
  #and then the scheduler replaying a bunch of old scheduled tasks
  if (Time.zone.now.utc.to_i - last_updated.to_i) > 20 #seconds
    f = Facebook.new
    f.sync_workouts
    last_updated = Time.zone.now.utc
  end
end 
