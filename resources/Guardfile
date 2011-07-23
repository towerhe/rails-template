# A sample Guardfile
# More info at https://github.com/guard/guard#readme
group 'backend' do
  guard 'bundler' do
    watch('Gemfile')
  end

  guard 'spork', :cucumber_env => { 'RAILS_ENV' => 'cucumber' }, :rspec_env => { 'RAILS_ENV' => 'test' } do
    watch('config/application.rb')
    watch('config/environment.rb')
    watch('config/routes.rb')
    watch(%r{^config/environments/.+\.rb$})
    watch(%r{^config/initializers/.+\.rb$})
    watch('spec/spec_helper.rb')
    watch(%r{^spec/factories/.+\.rb$})
  end

  guard 'rspec', :cli => '--color --format doc' do
    watch('spec/spec_helper.rb')                       { "spec" }
    watch('config/routes.rb')                          { "spec/routing" }
    watch('app/controllers/application_controller.rb') { "spec/controllers" }
    watch(%r{^spec/.+_spec\.rb})
    watch(%r{^app/(.+)\.rb})                           { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^lib/(.+)\.rb})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch(%r{^app/controllers/(.+)_(controller)\.rb})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  end

  guard 'cucumber', :cli => '--profile guard' do
    watch(%r{features/.+\.feature})
    watch(%r{features/support/.+})          { 'features' }
    watch(%r{features/step_definitions/(.+)_steps\.rb}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
  end

  guard 'rails', :port => 3000 do
    watch('Gemfile.lock')
    watch(%r{^(config|lib)/.*})
  end
end


