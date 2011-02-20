module GitHubAPI
  include Octopi

  def repositories(username)
    puts "repositories"
    Octopi::Repository.find(:user => username)
  end

  def commits(username)
    puts "commits"
    unless (repos = repositories(username)).empty?
      repos.map(&:commits).flatten.select do |c|
        c.committer['login'] == username
      end.sort { |a,b| b.committed_date <=> a.committed_date }
    end
  end

  # In production, authenticate before calling the API methods defined above.
  # The reason we do this is because we can't rely on GitHub's API rate limiting
  # based on IP address, since we are sharing IP space on Heroku.
  #
  instance_eval do
    instance_methods(false).each do |method|
      alias_method "#{method}_without_authentication", method

      define_method method do |username|
        puts "logging in as #{ENV['GITHUB_LOGIN']} with token #{ENV['GITHUB_TOKEN']}"
        authenticated_with :login => ENV['GITHUB_LOGIN'], :token => ENV['GITHUB_TOKEN'], :trace => ENV['GITHUB_API_TRACE'] do
          send "#{method}_without_authentication", username
        end
      end
    end
  end if Rails.env.production?
end
