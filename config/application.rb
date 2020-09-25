require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BollingerRailsApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # generateコマンド時に生成されるファイルに制限をかける
    config.generators do |g|
      g.assets false # CSS, JSが自動生成されない
      g.test_framework false # Minitestが自動生成されない
    end

    # タイムゾーンの設定
    config.time_zone = 'Tokyo'
    # デフォルトのロケールを日本に設定
    config.i18n.default_locale = :ja
  end
end
