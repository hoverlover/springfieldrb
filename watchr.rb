ENV["WATCHR"] = "1"
system 'clear'

def growl(message)
  growlnotify = `which growlnotify`.chomp
  title = "Watchr Test Results"
  image_path = "~/.watchr_images/"

  image = case message
    when /([1-9]\d+|[1-9]) fail(ed|ures?)/ then 'failed'
    when /([1-9]\d+|[1-9]) errors?/ then 'error'
    when /([1-9]\d+|[1-9]) pending/ then 'pending'
    when /0 fail(ed|ures?)/ then 'passed'
    when /([1-9]\d+|[1-9]) passed/ then 'passed'
    else
      'info'
  end

  options = "-w -n Watchr --image '#{File.expand_path("#{image_path}#{image}.png")}' -m '#{message}' '#{title}'"
  system %(#{growlnotify} #{options} &)
end

def format_result(result, output_from = :rspec)
  result = result.split("\n")
  output_from == :rspec ? result.last : result[-3..-2].join("\n")
end

def run(cmd)
  puts(cmd)
  `#{cmd}`
end

def run_spec_file(file)
  system('clear')
  result = run(%Q(rspec #{file}))
  growl format_result(result) rescue nil
  puts result
end

def run_all_specs
  system('clear')
  result = run "rake spec"
  growl format_result(result) rescue nil
  puts result
end

def related_spec_files(path)
  Dir['spec/**/*.rb'].select { |file| file =~ /#{File.basename(path).split(".").first}_spec.rb/ }
end

def run_suite
  run_all_specs
end

watch('spec/factories\.rb') { run_suite }
watch('spec/.*_spec\.rb') { |m| run_spec_file(m[0]) }
watch('app/.*\.rb') { |m| related_spec_files(m[0]).map {|tf| run_spec_file(tf) } }

# Ctrl-\
Signal.trap 'QUIT' do
  puts " --- Running all specs ---\n\n"
  run_suite
end

# Ctrl-C
Signal.trap 'INT' do abort("\n") end

puts "Watching ..."
