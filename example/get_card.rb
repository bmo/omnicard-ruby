$:.unshift File.join(File.dirname(__FILE__), "/../lib")

require 'omnicard_ruby.rb'
require 'redis'

DEFAULT_OPTIONS = { :username => ENV['OMNICARD_USER'],
                    :password => ENV['OMNICARD_PASSWORD'],
                    :endpoint => 'https://api.omnicard.com/2.x' }

c = Omnicard::Client.new(DEFAULT_OPTIONS)

puts c.inspect

card_id = 53075251

if c.login()
  begin
    r = c.card(card_id)
  rescue Omnicard::Error => ex
    raise
  end

  File.open("card_#{card_id}.json", 'w') {|f| f.write(r.to_json) }

  puts JSON.pretty_generate(r['message'])

end
