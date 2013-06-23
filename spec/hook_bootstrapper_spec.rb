require 'hook_bootstrapper'

class FakeGithubClient
  attr_reader :last_created_hook

  def initialize
    @last_created_hook = {}
  end

  def create_hook(repo, name, config, options = {})
    @last_created_hook = {
        repository: repo,
        name: name,
        config: config,
        options: options
    }
  end
end

describe HookBootstrapper do
  let(:client) { FakeGithubClient.new }
  let(:bootstrapper) { described_class.new(client, callback_url) }

  let(:repository) { 'xoebus/test' }
  let(:callback_url) { 'http://example.com/cla' }

  describe 'bootstrapping service hooks for repositories' do
    context 'when the hook does not already exist' do
      it 'creates the service hook' do
        bootstrapper.bootstrap_repository(repository)

        last_hook = client.last_created_hook
        expect(last_hook[:repository]).to eq(repository)
        expect(last_hook[:name]).to eq('web')
        expect(last_hook[:config]).to eq({
            url: callback_url,
            content_type: 'json'
        })
        expect(last_hook[:options]).to eq({
            events: %w(pull_request),
            active: true
        })
      end
    end
  end
end