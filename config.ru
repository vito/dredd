require 'octokit'

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require 'dredd'


TEMPLATE = <<-EOT
Hey <%= username %>!

Thanks for submitting this pull request!
EOT

config = Dredd::Config.from_file('config/config.example.yml')
github_client = Octokit::Client.new(login: config.username,
    token: config.token)
commenter = Dredd::PullRequestCommenter.new(github_client, TEMPLATE)
filterer = Dredd::UsernameFilterer.new(commenter, config.allowed_usernames)

Dredd::DreddApp.set :commenter, filterer

run Dredd::DreddApp
