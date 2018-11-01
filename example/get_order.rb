$:.unshift File.join(File.dirname(__FILE__), "/../lib")

require 'omnicard_ruby.rb'
require 'redis'

DEFAULT_OPTIONS = { :username => ENV['OMNICARD_USER'],
                    :password => ENV['OMNICARD_PASSWORD'],
                    :endpoint => 'https://api.omnicard.com/2.x' }

c=Omnicard::Client.new(DEFAULT_OPTIONS)

order_id = 52229821 

if c.login()
  begin
    r = c.order(order_id)
  rescue Omnicard::Error => ex
    raise
  end

  File.open("order_#{order_id}_details.json", 'w') {|f| f.write(r.to_json) }

  puts JSON.pretty_generate(r['response']['message'])

end
