Rollbar.configure do |config|
  config.access_token = '84d8d521c1844fef98d2f4b15fef7cb2'

  if Rails.env.test?
    config.enabled = false
  end

  config.environment = ENV['ROLLBAR_ENV'].presence || Rails.env
end
