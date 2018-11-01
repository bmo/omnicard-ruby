require 'spec_helper'

describe 'funds' do
  subject do
    Omnicard::Client.new(DEFAULT_OPTIONS)
  end


  before do
    # stub the login
    stub_post('apiUsers/auth.json', 'auth_success')

    stub_post('funds/getAccounts.json', 'get_accounts')
  end

  it 'retrieves a list of accounts' do
    subject.login
    expect(subject.accounts.status).to eq(1000)
    expect(subject.accounts.message.account.transaction.length).to eq(3)
  end
end