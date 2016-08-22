Rails.configuration.blockscore = {
    api_key: ENV['RAILS_ENV'] == 'production' ? ENV['BLOCKSCORE_LIVE_KEY']: ENV['BLOCKSCORE_TEST_KEY']
}

BlockScore.api_key = Rails.configuration.blockscore[:api_key]