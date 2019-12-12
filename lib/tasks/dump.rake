namespace :dump do
  desc "To run use: rails dump:fetch"
  task :fetch => :environment do
    command = 'cd /home/thoughtwin/simple_projcts/Demo_post_project/&& PGPASSWORD="ubuntu" pg_dump -U postgres -h localhost demo_project_development3 > backup_using_rake_task.dump'
    exec command
  end
end
