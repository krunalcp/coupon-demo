source 'https://rubygems.org'

# Ruby Version
ruby '2.3.1'

# Framework
gem 'rails', '~> 5.0.3'
gem 'haml'
gem 'font-awesome-rails'
gem 'kaminari', '0.17.0'
gem 'cocoon'
gem 'nokogiri', '1.6.8'

# Asset
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'

# Api
gem 'jbuilder', '~> 2.5'

# For excel file read
gem 'roo', '2.3.0'
gem 'roo-xls'

# Authentications & Security
gem 'devise'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :production do
  # Database
  gem 'pg'
end

group :development do
  # Database
  gem 'mysql2', '~> 0.4.5'
  # Environment Variable
  gem 'figaro'

  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
