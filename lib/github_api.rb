module GitHubAPI
  include Octopi

  def repositories(username)
    Octopi::Repository.find(:user => username)
  end

  def commits(username)
    unless (repos = repositories(username)).empty?
      repos.map(&:commits).flatten.select do |c|
        c.committer['login'] == username
      end.sort { |a,b| b.committed_date <=> a.committed_date }
    end
  end
end
