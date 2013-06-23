class HookBootstrapper
  def initialize(client, callback_url)
    @client = client
    @callback_url = callback_url
  end

  def bootstrap_repository(repository)
    @client.create_hook(
        repository, 'web',
        {
            url: @callback_url,
            content_type: 'json'
        },
        {
            events: %w(pull_request),
            active: true
        }
    )
  end
end