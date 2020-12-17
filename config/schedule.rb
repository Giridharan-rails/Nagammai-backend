# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
 every '0 0 1 * *' do
#   command "/usr/bin/some_great_command"
   runner "Appointment.monthly_appointment_create",:environment=> :development
#   rake "some:great:rake:task"
 end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
