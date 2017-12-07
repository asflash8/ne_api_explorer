source 'https://rubygems.org'
ruby '~> 2.4.2'

gem 'rake'
gem 'hanami',       '~> 1.1'
gem 'hanami-model', '~> 1.1'

gem 'ne_api'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun'
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
  gem 'sqlite3'
end

group :test do
  gem 'minitest'
  # gem 'capybara'
end

group :production do
  gem 'puma'
end
