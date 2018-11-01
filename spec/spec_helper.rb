require 'rubygems'
require 'bundler/setup'
require 'webmock/rspec'
require 'omnicard'

DEFAULT_OPTIONS = { :username => 'trucentives', :password => '8mazingbuttrue', :endpoint => 'https://api.omnicard.com/2.x' }

def stub_post(endpoint, json_stub)
  body = load_fixture(json_stub)
  stub_request(:post, "https://api.omnicard.com/2.x/#{endpoint}").
    to_return(:status => 200, :body => body, :headers => {})
end

def load_fixture(file_name)
  file = File.open(File.join(Dir.pwd, 'spec', 'fixtures', "#{file_name}.json"))
  contents = file.read
  file.close
  contents
end