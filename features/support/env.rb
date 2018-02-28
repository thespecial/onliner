# frozen_string_literal: true

require 'dotenv'
require 'cucumber'
require 'page-object'
require 'page-object/page_factory'
require 'parallel_tests'
require 'rspec/expectations'
require 'selenium-webdriver'
require 'watir-nokogiri'
require 'yaml'
require_relative 'constants'
require_relative 'selectors'

# Load env variables
Dotenv.load

puts ENV['SECTIONS_FOLDER']
puts '============'
puts File.join(Dir.pwd, ENV['SECTIONS_FOLDER'], '*')
puts '============'
puts Dir.glob(File.join(Dir.pwd, ENV['SECTIONS_FOLDER'], '*'))

# Require all necessary files
# current_dir = File.dirname(File.absolute_path(__FILE__))
Dir.glob(File.join(Dir.pwd, ENV['SECTIONS_FOLDER'], '*')) { |file| require_relative file }

World(PageObject::PageFactory)

PageObject.default_element_wait = 15

def current_url
  @browser.current_url
end

# Selenium wait
def wait
  Selenium::WebDriver::Wait.new(timeout: 15)
end

# Chrome headless options
def headless_options
  chrome_options = Selenium::WebDriver::Chrome::Options.new
  chrome_options.add_argument('--no-sandbox')
  chrome_options.add_argument('--headless')
  chrome_options.add_argument('--disable-gpu')

  { options: chrome_options }
end

# Read config
def prepare_config
  config_path = File.join(Dir.pwd, ENV['CONFIG_FOLDER'], ENV['CONFIG_FILE'])

  # YAML.load_file returns false if file is empty.
  config = YAML.load_file(config_path) || {} if File.exist?(config_path)
  config = Hash[config.map { |k, v| [k.to_sym, v] }] unless config.empty?

  {
    browser: config[:browser]  || 'chrome',
    screen:  config[:screen]   || [1440, 900],
    headless:  config[:headless] || false
  }
end

Before do
  config = prepare_config

  begin
    opts = if config[:browser].eql?('chrome') && config[:headless]
             headless_options
           else
             {}
           end

    @browser = Selenium::WebDriver.for config[:browser].to_sym, opts
  rescue StandardError => error
    puts 'Can\'t invoke browser! Please, check your config.'
    puts error
  end

  @browser.manage.window.move_to(0, 0)
  @browser.manage.window.resize_to(config[:screen][0], config[:screen][1])
end

After do
  @browser.quit
end
