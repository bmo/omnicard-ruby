$:.unshift File.join(File.dirname(__FILE__), "/../lib")

require 'omnicard_ruby.rb'
require 'redis'

DEFAULT_OPTIONS = {:username => ENV['OMNICARD_USER'],
                   :password => ENV['OMNICARD_PASSWORD'],
                   :endpoint => 'https://api.omnicard.com/2.x'}

c=Omnicard::Client.new(DEFAULT_OPTIONS)

if c.login(true,faraday_logging: true)
  begin
    r = c.accounts
  rescue Omnicard::Error => ex
    raise
  end

  File.open("accounts.json", 'w') { |f| f.write(r.to_json) }

  puts r.inspect

  if Omnicard::Request.success?(r)
    puts JSON.pretty_generate(r['response']['message'])
  end
else
  puts "Failed to log in"
end


