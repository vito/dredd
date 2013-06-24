require 'psych'

module Dredd
  class Config
    def self.from_file(file_path)
      hash = Psych.load_file(file_path)
      new(hash)
    end

    def initialize(hash)
      @hash = hash
    end

    def username
      @hash.fetch('credentials').fetch('username')
    end

    def token
      @hash.fetch('credentials').fetch('token')
    end

    def callback_url
      @hash.fetch('callback_url')
    end

    def repositories
      @hash.fetch('repositories')
    end
  end
end