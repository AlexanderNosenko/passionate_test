source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.3'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

gem 'rack-cors'

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'overcommit' # pre-commit/pre-push configurator
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # gem "letter_opener"
  # Scaffold generator
  gem 'module_scaffold', github: 'AlexanderNosenko/module_scaffold'
end

group :test do
  gem 'rspec-rails', '~> 3.9'
  gem 'airborne' # rspec json assertions
  gem 'database_cleaner'
  gem 'pundit-matchers'
  gem 'test-prof'
end

group :development, :test do
  gem 'byebug', platforms: %i(mri mingw x64_mingw)
  gem 'faker'
  gem 'factory_bot_rails'
  gem 'rswag-specs'
  gem 'rswag-api'
end

group :develoment, :ci do
  gem 'brakeman', require: false
  gem 'fasterer', require: false
  gem 'rails_best_practices', require: false
  gem 'rubocop', '~> 0.73.0', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
end

# gem 'jwt' # authentication
# gem 'bcrypt' # authentication
gem 'fast_jsonapi' # json response
gem 'pundit' # authorization
gem 'draper' # decorating AR models
gem 'sidekiq' # job scheduler
gem 'redis-namespace', '~> 1.6' # dependencies for sidekiq
gem 'olive_branch' # accept camelCase requests

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i(mingw mswin x64_mingw jruby ruby)
