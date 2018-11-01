module Omnicard
  class Client
    # Defines methods related to Omnicard funds
    module Orders

      def order_programs(options = {exclude_virtual:true,  exclude_physical:true,  exclude_omnicode:true})
        # options can include :exclude_virtual, :exclude_physical, :exclude_omnicode
        try_with_relogin do
          post('orderOptions/getPrograms.json', options)
        end
      end

      def order_clients()
        try_with_relogin do
        post ('orderOptions/getEndClients.json')
        end
      end


      # poll this with an id to see if it's completed
      def orders(id)
        try_with_relogin do
          post('orders/getOrders.json')
        end
      end

      def order(id)
        try_with_relogin do
          post('orders/getOrder.json', order_id: id)
        end
      end

    end
  end
end
