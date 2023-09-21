class ApplicationJob
  include Sidekiq::Worker
  include Sidekiq::Throttled::Worker
end
