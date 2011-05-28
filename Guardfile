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
    watch(%r{^spec/.+_spec\.rb})
    watch(%r{^lib/(.+)\.rb})         { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch(%r{^app/models/(.+)\.rb})  { |m| "spec/models/#{m[1]}_spec.rb" }
    watch(%r{^app/controllers/(.+)\.rb})  { |m| "spec/controllers/#{m[1]}_spec.rb" }
    watch(%r{^spec/models/.+\.rb})   { ["spec/models", "spec/acceptance"] }
    watch(%r{^spec/.+\.rb})          { `say hello` }

    watch('spec/spec_helper.rb') { "spec" }
  end

  guard 'cucumber', :cli => '--drb --require features/support --require features/step_definitions'  do
    watch(%r{features/.+\.feature})
    watch(%r{features/support/.+})          { 'features' }
    watch(%r{features/step_definitions/(.+)_steps\.rb}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
  end
end

