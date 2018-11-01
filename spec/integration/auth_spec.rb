require 'spec_helper'

describe 'auth' do
  subject do
    Omnicard::Client.new(DEFAULT_OPTIONS)
  end

  before do
    stub_post('apiUsers/auth.json', 'auth_success')
  end

  it 'auths' do
    expect(subject.login).to be(true)
  end
end