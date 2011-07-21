# remove files
run "rm README"
run "rm public/index.html"
run "rm public/images/rails.png"
run "cp config/database.yml config/database.yml.example"

# install gems
run "rm Gemfile"
file 'Gemfile', File.read("#{File.dirname(rails_template)}/resources/Gemfile")

# bundle install
run "bundle install"

# generate rspec
generate "rspec:install"
generate "cucumber:install --capybara --rspec --spork"

# configure cucumber
run "rm config/cucumber.yml"
file "config/cucumber.yml", File.read("#{File.dirname(rails_template)}/resources/config/cucumber.yml")

# copy files
file 'Guardfile', File.read("#{File.dirname(rails_template)}/resources/Guardfile")
run "rm spec/spec_helper.rb"
file 'spec/spec_helper.rb', File.read("#{File.dirname(rails_template)}/resources/spec/spec_helper.rb")
file 'lib/tasks/dev.rake', File.read("#{File.dirname(rails_template)}/resources/lib/tasks/dev.rake")

# remove active_resource and test_unit
gsub_file 'config/application.rb', /require 'rails\/all'/, <<-CODE
require 'rails'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
CODE

# install jquery
run "curl -L http://code.jquery.com/jquery.min.js > public/javascripts/jquery.js"
run "curl -L http://github.com/rails/jquery-ujs/raw/master/src/rails.js > public/javascripts/rails.js"

gsub_file 'config/application.rb', /(config.action_view.javascript_expansions.*)/, 
                                   "config.action_view.javascript_expansions[:defaults] = %w(jquery rails)"

# add time format
environment 'Time::DATE_FORMATS.merge!(:default => "%Y/%m/%d %I:%M %p", :ymd => "%Y/%m/%d")'

file 'VERSION', File.read("#{File.dirname(rails_template)}/resources/VERSION")
