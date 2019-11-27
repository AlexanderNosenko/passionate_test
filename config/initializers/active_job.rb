Rails.application.configure do
  # Use a real queuing backend for Active Job (and separate queues per environment)
  config.active_job.queue_adapter = :sidekiq
  config.active_job.queue_name_prefix = "passionate_task_#{Rails.env}"
end
