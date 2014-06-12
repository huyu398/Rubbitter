require 'yaml'
require 'oauth'

module Rubbitter
  class Config
    CONFIG_FILE = File.expand_path('~/.rubbitter.yml')

    attr_accessor :property

    def initialize
      if File.exist?(CONFIG_FILE)
        @property = YAML.load_file(CONFIG_FILE)
      else
        # Rubbitter::Authentication.launch
        # [todo] - Preceding code is gui function. CLI test code is following.
        @property = cli_auth
        File.open(CONFIG_FILE, 'w') { |f| YAML.dump(@property, f) }
      end
    end

    private

    CONSUMER_KEY = 'ewiaRHXxQto8bl5izWdB1bsgK'
    CONSUMER_SECRET = 'fgZ0wbl5FuNaF2CacWa3Tf0XBqF2YMcXk971P4cYXTojQ60iNI'

    def cli_auth
      consumer = OAuth::Consumer.new(
        CONSUMER_KEY,
        CONSUMER_SECRET,
        site: 'https://api.twitter.com'
      )

      request_token = consumer.get_request_token
      puts request_token.authorize_url

      pin = gets.chomp
      access_token = request_token.get_access_token(oauth_verifier: pin)

      { token: { access_token: access_token.token, access_token_secret: access_token.secret } }
    end
  end
end
