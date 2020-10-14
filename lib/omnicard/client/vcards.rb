module Omnicard
  class Client
    # Defines methods related to Omnicard egifts
    module VCards
      # provide order_id as an option to get specific to an order
      def vcard(card_id, options = {})
        try_with_relogin do
          post("virtualCards/getCard.json", {card_id: card_id})
        end
      end

      def vcard_by_code(code, options = {})
        try_with_relogin do
          post("virtualCards/getByCode.json", {code: code}.merge(options.slice(:order_id)))
        end
      end
      
      def virtual_merchants
        try_with_relogin do
          post(
              "orderOptions/getVirtualMerchants.json"
          )
        end
      end

      def virtual_merchant(merchant_code)
        try_with_relogin do
          post(
              "orderOptions/getVirtualMerchant.json", {merchant_code: merchant_code}
          )
        end
      end

      def end_clients()
        try_with_relogin do
          post(
              "orderOptions/getEndClients.json"
          )
        end
      end

      # options[:contact_info] must have :name, :email, :organization, optional: :phone
      # options[:end_client_id] must be present - get it from end_clients

      def virtual_order_start(merchant_code,  merchant_template_id, options)
        try_with_relogin do
          contact_info = options[:contact_info]
          post(
              "virtualOrders/start.json",
              {
                  end_client_id: options[:end_client_id], merchant_code: merchant_code, merchant_template_id: merchant_template_id,
                  delivery: 'download', from: options[:from],
                  contact: {
                      name: contact_info&[:name],
                      email: contact_info&[:email],
                      organization: contact_info&[:organization],
                      phone: contact_info&[:phone],
                  }
               }
          )
        end
      end

      def add_virtual_card(order_id, denomination, first_name, last_name, message)
        try_with_relogin do
          post(
              'virtualOrders/addCard.json',
              {
                  order_id: order_id,
                  card:
                      {
                          denomination: denomination, first_name: first_name, last_name: last_name, message:message
                      }
              }
          )
        end
      end

      def virtual_order_complete(order_id, options)
        # { options: { digital_signature: 'Ima Bott',
        #             payment_type: 'check' } } # check, wire, fundsbank
        #             # account_id: 123         # fundsbank account number only required for that method of payment
        try_with_relogin do
          post('virtualOrders/complete.json', {order_id: order_id}.merge(options))
        end
      end
    end
  end
end
