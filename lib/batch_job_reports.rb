class BatchJobReports
  
	def self.batch_job_report_csv cron_job_info
    CSV.generate(headers: batch_job_column_headers, write_headers: true) do |csv|
      task_list = cron_job_info.split("\n").reject(&:empty?)[0..-3]
      modified_tasks = task_list.map do |task|
        time, name = task.split "/bin/bash -l -c 'RAILS_ENV=production bundle exec rake "
        name.slice!(" --silent'")
        [name, time]
      end
      modified_tasks.each do |name, cron_time_syntax|
        cron_time = CronParser.new(cron_time_syntax)
        most_recent_time = cron_time.last(Time.now)
        next_coming_time = cron_time.next(Time.now)
        csv << [name, most_recent_time, next_coming_time]
      end
    end
  end

  private

  def self.batch_job_column_headers
    ["Task Name", "Last Ran", "Next Run"]
  end

end