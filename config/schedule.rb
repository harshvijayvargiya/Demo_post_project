# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# start running your cron jobs
# whenever --update-crontab

# you can check which cron jobs are active with
# crontab -l
# crontab -e

# And remove with
# crontab -r

# Will clear your crontab file
# whenever -c

set :output, "log/whenever.log"

every 1.minutes do
  rake "fetch"
  
  command "cd /home/thoughtwin/simple_projcts/Demo_post_project/&& ~/dump.sh"

  # command "rm /home/thoughtwin/simple_projcts/Demo_post_project/senger.new(message).call"
  
  # command "cd /home/thoughtwin/simple_projcts/Demo_post_project && /usr/local/bin/pg_dump -U postgres -h localhost demo_project_development3 > backup_using_cron_job.dump"
end
