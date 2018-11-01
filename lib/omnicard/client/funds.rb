module Omnicard
  class Client
    # Defines methods related to Omnicard funds
    module Funds

      def accounts
        try_with_relogin do
          post("funds/getAccounts.json")
        end
      end

      def account(account_id)
        try_with_relogin do
          post("funds/getAccount.json", {account_id: account_id})
        end
      end

      def add_funds(account_id, amount, payment_method)
        # payment method must be 'check' or 'wire'

        try_with_relogin do
          post("funds/add.json", {account_id: account_id, amount: amount, payment_method: payment_method})
        end
      end

      def transfer_funds(from_account_id, to_account_id, amount)
        try_with_relogin do
          post("funds/transfer.json", {source: from_account_id, amount: amount, destination: to_account_id})
        end
      end

    end
  end
end