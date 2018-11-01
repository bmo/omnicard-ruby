$:.unshift File.join(File.dirname(__FILE__), "/../lib")

require 'omnicard_ruby.rb'
require 'redis'

DEFAULT_OPTIONS = { :username => ENV['OMNICARD_USER'],
                    :password => ENV['OMNICARD_PASSWORD'],
                    :endpoint => 'https://api.omnicard.com/2.x' }


c=Omnicard::Client.new(DEFAULT_OPTIONS)

if c.login(false)  #, auth_token:"d52f82efe493f68bc7715af425eb340c"
  begin
    r = c.merchants
  rescue Omnicard::Error => ex
    raise
  end

  File.open("merchants.json", 'w') {|f| f.write(r.to_json) }


  if Omnicard::Request.success?(r)
    details = []
    r['response']['message'].each do |m|
      puts("Code: #{m['merchant']['code']} \tMerchant: #{m['merchant']['name']} \tLogo: #{m['merchant']['logo']}")
      details << c.merchant(m['merchant']['code'])[:response][:message]
    end
  
    File.open("merchant_details.json", 'a') {|f| f.write(details.to_json) }
  end
  
end


