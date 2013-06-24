require 'sinatra'
require 'json'

module Dredd
  class DreddApp < Sinatra::Base
    get '/status' do
      'OK'
    end

    post '/' do
      comment(JSON.parse(request.body.read))
    end

    def comment(json_hash)
      commenter = settings.commenter
      pull_request = json_hash.fetch('pull_request')
      repo = pull_request.fetch('base').fetch('repo').fetch('full_name')
      number = pull_request.fetch('number')
      user = pull_request.fetch('user').fetch('login')
      commenter.comment(repo, number, user)
    end
  end
end