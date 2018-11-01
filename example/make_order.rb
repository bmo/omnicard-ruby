$:.unshift File.join(File.dirname(__FILE__), "/../lib")

require 'omnicard_ruby.rb'

DEFAULT_OPTIONS = { :username => ENV['OMNICARD_USER'],
                    :password => ENV['OMNICARD_PASSWORD'],
                    :endpoint => 'https://api.omnicard.com/2.x' }

c=Omnicard::Client.new(DEFAULT_OPTIONS)

if c.login
  r = c.merchants
  #File.open("out.json", 'w') {|f| f.write(r.to_json) }

  if Omnicard::Request.success?(r)

    safeway_card =  r['response']['message'].select{|c| c['merchant']['name'].start_with?("Safeway")}.first
    id = safeway_card['merchant']['code']
    puts "Safeway code is #{id} for #{safeway_card.inspect}"

    # get information about the merchant...
    merchant_info = c.merchant(id)


    if Omnicard::Request.success?(merchant_info)

      File.open("merchant_#{id}.json", 'w') { |f| f.write(merchant_info.to_json) }
      
      # start the order
      order = c.order_start(id, merchant_info['response']['message']['merchant']['templates'].first['id'])
      puts "ORDER #{order.inspect}"
      File.open("order_#{id}.json", 'w') { |f| f.write(order.to_json) }

      if Omnicard::Request.success?(order)
        order_id = order['response']['message']['order_id']
        card = c.add_card(order_id, card:{first_name:'Test', last_name:'User',  denomination: 25.00, message:'Thank you for being a test subject.'})

        puts "ADD_CARD #{card}"

        File.open("order_#{id}.json", 'a') { |f| f.write(order.to_json) }

        if Omnicard::Request.success?(card)
        end

        complete = c.order_complete(order_id,  options: {digital_signature: 'Ima Bott', payment_type: 'wire'})
        puts "COMPLETE #{complete}"

        File.open("order_#{id}.json", 'a') { |f| f.write(complete.to_json) }

      end

    end
  end

end


