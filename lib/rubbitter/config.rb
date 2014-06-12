require 'yaml'
require 'oauth'

module Rubbitter
  class Config
    CONFIG_FILE = File.expand_path('~/.rubbitter.yml')

    @@token_hash = nil

    attr_accessor :property

    def initialize
      if File.exist?(CONFIG_FILE)
        @property = YAML.load_file(CONFIG_FILE)
      else
        Rubbitter::Interface::AuthenticationApp.launch
        @property = @@token_hash
      end
    end

    def self.make_config_file(token_hash)
      @@token_hash = token_hash
      File.open(CONFIG_FILE, 'w') { |f| YAML.dump(@@token_hash, f) }
    end
  end
end
