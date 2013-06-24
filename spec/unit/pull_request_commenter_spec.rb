require 'dredd/pull_request_commenter'

describe Dredd::PullRequestCommenter do
  let(:client) { double('GitHub Client') }
  let(:template) { 'hello <%= username %>' }
  let(:commenter) { described_class.new(client, template) }

  let(:repository) { 'xoebus/test-repo' }
  let(:pull_request_number) { 55 }
  let(:username) { 'seadowg' }

  describe 'making a comment' do
    it 'makes a comment' do
      client.should_receive(:add_comment).with(repository, pull_request_number, anything)
      commenter.comment(repository, pull_request_number, username)
    end

    it 'populates a template' do
      client.should_receive(:add_comment).with(repository,
          pull_request_number, 'hello seadowg')
      commenter.comment(repository, pull_request_number, username)
    end
  end
end