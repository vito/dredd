require 'erb'

module Dredd
  class PullRequestCommenter
    def initialize(client, template)
      @client = client
      @template = ERB.new(template)
    end

    def comment(repository, pull_request_number, username)
      context = RenderingContext.new(username)
      comment = @template.result(context.get_binding)
      @client.add_comment(repository, pull_request_number, comment)
    end

    class RenderingContext
      attr_reader :username

      def initialize(username)
        @username = username
      end

      def get_binding
        binding
      end
    end
  end
end