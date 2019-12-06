#!/bin/sh
cd /home/thoughtwin/simple_projcts/Demo_post_project/ && PGPASSWORD="ubuntu" pg_dump -U postgres -h localhost demo_project_development3 > backup_using_cron_job.dump

