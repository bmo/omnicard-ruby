module Omnicard
  class Client
    # Defines methods related to Omnicard egifts
    module VCards
      # provide order_id as an option to get specific to an order
      def vcard(card_id, options = {})
        try_with_relogin do
          post("virtualCards/getByCode.json", {card_id: card_id}.merge(options.slice(:order_id)))
        end
      end

      def register_vcard(card_id, card_number, first, last, address1, address2, city, state, zip)
        # card_id or card_number must be supplied
        values = {first: first, last: last, address1: address1, address2: address2, city: city, state: state, zip: zip}
        id_hsh = card_id.blank? ? {card_number: card_number} : {card_id: card_id}

        try_with_relogin do
          post(
              "virtualCards/register.json",
              id_hsh.merge(values)
          )
        end

      end
    end
  end
end
