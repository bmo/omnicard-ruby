module Omnicard
  class Client
    # Defines methods related to Omnicard funds
    module EGifts

      def card(card_id)
        try_with_relogin do
          post("egiftCards/getCard.json", {card_id: card_id})
        end
      end

      def send_redemption_email(card_id, email=nil)
        # payment method must be 'check' or 'wire'
        try_with_relogin do
          post("egiftCards/sendEmail.json", {card_id: card_id, email: email})
        end
      end

      # -- Catalog Related --
      def merchants
        try_with_relogin do
          post('orderOptions/getMerchants.json')
        end
      end

      def merchant(merchant_code)
        try_with_relogin do
          post('orderOptions/getMerchant.json', merchant_code: merchant_code)
        end
      end

      def order_start(merchant_code, merchant_template_id, delivery_method='download')
        try_with_relogin do
          post('egiftOrders/start.json',
               merchant_code: merchant_code,
               merchant_template_id: merchant_template_id,
               delivery: delivery_method)
        end
      end

      def add_card(order_id, options)
        try_with_relogin do
          post('egiftOrders/addCard.json', {order_id: order_id}.merge(options))
        end
      end

    end

    def order_complete(order_id, options)
      # { options: { digital_signature: 'Ima Bott',
      #             payment_type: 'check' } } # check, wire, fundsbank
      #             # account_id: 123         # fundsbank account number only required for that method of payment
      try_with_relogin do
        post('egiftOrders/complete.json', {order_id: order_id}.merge(options))
      end
    end
  end
end
