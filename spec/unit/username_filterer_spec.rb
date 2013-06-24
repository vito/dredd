require 'dredd/username_filterer'

describe Dredd::UsernameFilterer do
  let(:commenter) { double('Commenter') }
  let(:filterer) { described_class.new(commenter, username_list) }

  let(:username_list) { %w(xoebus seadowg) }
  let(:repository) { 'xoebus/test-repo' }
  let(:pull_request_number) { 55 }

  describe 'filtering usernames' do
    context 'when the user is in the filter list' do
      it 'does not call through' do
        commenter.should_not_receive(:comment)

        filterer.comment(repository, pull_request_number, 'xoebus')
        filterer.comment(repository, pull_request_number, 'seadowg')
      end
    end

    context 'when the user is not in the filter list' do
      it 'calls through' do
        commenter.should_receive(:comment).with(repository,
                                                pull_request_number,
                                                'tissarah')

        filterer.comment(repository, pull_request_number, 'tissarah')
      end
    end
  end
end