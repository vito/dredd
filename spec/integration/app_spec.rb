require 'rack/test'

require 'dredd/app'

set :environment, :test

describe Dredd::DreddApp do
  include Rack::Test::Methods

  def app
    described_class.new
  end

  describe 'reporting its status' do
    it 'responds with "OK"' do
      get '/status'
      last_response.should be_ok
      last_response.body.should == 'OK'
    end
  end
end