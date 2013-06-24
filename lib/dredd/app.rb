require 'sinatra'

module Dredd
  class DreddApp < Sinatra::Base
    get '/status' do
      'OK'
    end
  end
end