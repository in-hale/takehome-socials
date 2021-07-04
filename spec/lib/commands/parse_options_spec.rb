# frozen_string_literal: true

describe Commands::ParseOptions do
  let(:default_options) { { default: 'option' } }

  it 'returns default options when raw arguments are empty' do
    expect(described_class.new(default_options, []).call).to eq default_options
  end

  it 'parses the raw arguments if they are not empty' do
    raw_arguments = [
      'reddit threads https://test_reddit.com',
      'pinterest photos https://test_pinterest.com'
    ]

    expect(described_class.new(default_options, raw_arguments).call).to eq(
      sources: [
        Models::Source.new(
          name: 'reddit',
          key: 'threads',
          url: 'https://test_reddit.com'
        ),
        Models::Source.new(
          name: 'pinterest',
          key: 'photos',
          url: 'https://test_pinterest.com'
        )
      ]
    )
  end

  it 'raises an exception if encounters an incorrect input', :aggregate_failures do
    incorrect_inputs = [
      'name key',
      'name key redundant_key https://correct-url.com',
      'name key incorrect-url.com'
    ]

    incorrect_inputs.each do |incorrect_input|
      expect { described_class.new({}, [incorrect_input]).call }.to raise_error(
        Errors::InvalidSourceDefinition
      )
    end
  end
end
