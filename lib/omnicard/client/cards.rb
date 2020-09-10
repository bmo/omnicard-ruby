module Omnicard
  class Client
    # General card operations
    module Cards
      #cards/getBalance.json

      def balance(card_id, card_number = nil)
        # card_id or card_number must be supplied
        id_hsh = card_id.blank? ? {card_number: card_number} : {card_id: card_id}

        try_with_relogin do
          post(
              "cards/getBalance.json",
              id_hsh
          )
        end
      end

      def card_info(card_id, card_number = nil)
        # card_id or
        # card_number must be supplied
        id_hsh = card_id.blank? ? {card_number: card_number} : {card_id: card_id}

        try_with_relogin do
          post(
              "cards/getCard.json",
              id_hsh
          )
        end
      end

      def transactions(card_id, card_number = nil)
        id_hsh = card_id.blank? ? {card_number: card_number} : {card_id: card_id}

        try_with_relogin do
          post(
              "cards/getTransactions.json",
              id_hsh
          )
        end
      end

      def activate(card_id, card_number = nil, activation_code = nil)
        id_hsh = card_id.blank? ? {card_number: card_number} : {card_id: card_id}
        id_hsh = id_hsh.merge({activation_code: activation_code}) if activation_code

        try_with_relogin do
          post(
              "cards/activate.json",
              id_hsh
          )
        end
      end

      def register(card_id, card_number, first, last, address1, city, state, zip, ssn, birth_date, phone, optional_values)
        # optional_values may include :address2, :drivers_license, :email
        id_hsh = card_id.blank? ? {card_number: card_number} : {card_id: card_id}
        values = {first_name: first, last_name: last, address1: address1, city: city, state: state, zip: zip, ssn: ssn, birth_date: birth_date}
                     .merge(optional_values.slice(:address2, :drivers_license, :email))
        try_with_relogin do
          post(
              "cards/register.json",
              id_hsh
          )
        end
      end

      def reload(card_id, card_number, amount, method, account_id = nil)
        id_hsh = card_id.blank? ? {card_number: card_number} : {card_id: card_id}
        values = {amount: amount, payment_method: method}
        acct_hsh = account_id ? {account_id: account_id} : {}
        try_with_relogin do
          post(
              "cards/reload.json",
              id_hsh.merge(values).merge(acct_hsh)
          )
        end
      end
    end
  end
end

