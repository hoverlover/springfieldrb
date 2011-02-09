# A sample Guardfile
# More info at http://github.com/guard/guard#readme

guard 'spork' do
  watch %r{^config/.*\.(rb|yml)$}
  watch %r{^spec/support/.*\.rb$}
  watch 'spec/spec_helper.rb'
  watch %r{^spec/acceptance/support/.*\.rb$}
end

guard 'bundler' do
  watch 'Gemfile'
end
