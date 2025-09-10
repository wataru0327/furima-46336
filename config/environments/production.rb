require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # config.require_master_key = true

  config.public_file_server.enabled = true

  # config.assets.css_compressor = :sass
  config.assets.compile = false

  config.active_storage.service = :amazon

  # SSL を強制する設定は一時的にオフにする
  # config.force_ssl = true

  config.logger = ActiveSupport::Logger.new(STDOUT)
    .tap  { |logger| logger.formatter = ::Logger::Formatter.new }
    .then { |logger| ActiveSupport::TaggedLogging.new(logger) }

  config.log_tags = [ :request_id ]

  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  config.action_mailer.perform_caching = false

  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.active_record.dump_schema_after_migration = false
end

