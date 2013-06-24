module Dredd
  class UsernameFilterer
    def initialize(commenter, filtered_usernames)
      @commenter = commenter
      @filtered_usernames = filtered_usernames
    end

    def comment(repository, pull_request_number, username)
      return if should_filter?(username)
      @commenter.comment(repository, pull_request_number, username)
    end

    def should_filter?(username)
      @filtered_usernames.include? username
    end
  end
end