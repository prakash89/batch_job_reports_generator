require 'json'
require 'rspec'
require 'webmock/rspec'
require 'factory_girl'
require 'pry'
require './lib/batch_job_reports.rb'
require 'csv'
require 'cron_parser'

WebMock.disable_net_connect!(:allow => 'coveralls.io')