require 'spec_helper'

describe '.batch_job_report_csv' do
  let(:cron_job_info) do
    "30 21 * * * /bin/bash -l -c 'RAILS_ENV=production bundle exec rake account_transactions --silent'\n\n45 21 * * * /bin/bash -l -c 'RAILS_ENV=production bundle exec rake note_transactions --silent'\n\n## [message] Above is your schedule file converted to cron syntax; your crontab file was not updated.\n## [message] Run `whenever --help' for more options.\n"
  end

  it 'returns CSV string with headers' do
    csv_string = BatchJobReports.batch_job_report_csv cron_job_info

    expect(csv_string.split("\n").first).to eq('Task Name,Last Ran,Next Run')
  end

  it 'writes name of each batch job from whenever to csv' do
    csv_string = BatchJobReports.batch_job_report_csv cron_job_info
    csv_rows=CSV.parse csv_string
    expect(csv_rows[1][0]).to eq('account_transactions')
    expect(csv_rows[2][0]).to eq('note_transactions')
  end

end