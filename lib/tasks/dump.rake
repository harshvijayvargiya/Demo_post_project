namespace :dump do
  desc "To run use: rails dump:fetch"
  task :fetch => :environment do
    command = nil
    command = "pg_dump -U postgres -h localhost demo_project_development3 > backup_using_raketask.dump"
    exec command
  end
end
