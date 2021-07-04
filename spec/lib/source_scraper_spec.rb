# frozen_string_literal: true

describe SourceScraper do
  let(:subject) do
    described_class.new(
      available_sources: [
        Models::Source.new(name: 'instagram', key: 'photos', url: 'https://test_inst.com'),
        Models::Source.new(name: 'reddit', key: 'threads', url: 'https://test_reddit.com'),
        Models::Source.new(name: 'facebook', key: 'posts', url: 'https://test_facebook.com')
      ],
      source_names: %w[reddit instagram],
      http_client: http_adapter
    ).call
  end

  let(:http_adapter) { double }

  it 'fetches content from sources and retries until succeeds' do
    reddit_adapter_instance = double
    instagram_adapter_instance = double

    expect(http_adapter).to receive(:new).with('https://test_reddit.com').and_return(reddit_adapter_instance)
    expect(http_adapter).to receive(:new).with('https://test_inst.com').and_return(instagram_adapter_instance)

    expect(reddit_adapter_instance).to receive(:perform).and_return(
      double(body_str: [{ user: 'reddit_user', post: '<something about gaming>' }].to_json, status: '200')
    )
    expect(instagram_adapter_instance).to receive(:perform).and_return(
      double(body_str: 'got ya!', status: '500')
    )
    expect(instagram_adapter_instance).to receive(:perform).and_return(
      double(
        body_str: [{ user: 'instagram_user', post: '<philosophic statement and a random photo>' }].to_json,
        status: '200'
      )
    )

    expect(subject).to eq(
      'threads' => [{ 'user' => 'reddit_user', 'post' => '<something about gaming>' }],
      'photos' => [{ 'user' => 'instagram_user', 'post' => '<philosophic statement and a random photo>' }]
    )
  end
end
