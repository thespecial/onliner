# frozen_string_literal: true

require 'dotenv/load'
require 'report_builder'

task default: ['report:clear', 'test:normal']

namespace :test do
  desc 'Sequential tests execution'
  task :normal do
    sh 'bundle exec cucumber'
  end

  desc 'Parallel tests execution'
  task :parallel, [:n] do |_t, args|
    threads = args[:n].to_i.positive? ? "-n #{args[:n].to_i}" : ''
    sh "bundle exec parallel_cucumber features/ #{threads} --group-by scenarios"
  end

  task normal: 'report:clear'
  task parallel: 'report:clear'
end

desc 'Clear reports dir'
namespace :report do
  desc 'Clear reports folder'
  task :clear do
    reports_path = ENV['REPORTS_FOLDER']

    if Dir.exist?(reports_path)
      unless Dir.empty?(reports_path)
        Dir.open(reports_path).each do |filename|
          File.delete(File.join(reports_path, filename)) unless File.directory?(filename)
        end
      end
    else
      Dir.mkdir(reports_path)
    end
  end

  desc 'Generate report'
  task :build do
    files = Dir.entries(ENV['REPORTS_FOLDER']) - ['.', '..', 'index.html']

    if files.empty?
      puts 'Run tests to populate reports folder with relevant .json data before building report.'
      exit 1
    end

    options = { json_path: ENV['REPORTS_FOLDER'], report_path: File.join(ENV['REPORTS_FOLDER'], 'index') }
    ReportBuilder.build_report options
  end

  desc 'Start report server'
  task :run do
    if Dir.exist?(ENV['REPORTS_FOLDER']) && File.file?(File.join(ENV['REPORTS_FOLDER'], 'index.html'))
      puts "Running reports server on http://localhost:#{ENV['REPORTS_PORT']}"
      sh `cd reports; bundle exec ruby -run -e httpd . -p #{ENV['REPORTS_PORT']}`
    else
      puts 'Generate reports first with "rake report:build".'
      exit 1
    end
  end
end
