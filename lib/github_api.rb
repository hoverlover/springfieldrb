module GitHubAPI

  def self.included(base)
    base.send :include, HTTParty
    base.base_uri 'https://github.com/api/v2/json'

    # We want to authenticate with GitHub in production because of the way they do
    # rate limiting.  If you authorize, API calls are limited by account, otherwise they
    # are limited by IP address.  On Heroku, we will be sharing IP addresses with other
    # apps, so we want to authorize so our API call count will be separated from others
    # that might be on the same IP address.
    #
    base.basic_auth ENV['GITHUB_LOGIN'], ENV['GITHUB_TOKEN'] if Rails.env.production?
  end

  def repositories(username)
    JSON.to_ostruct(self.class.get("/repos/show/#{username}").body).repositories
  end

  def commits(username, branch = 'master')
    unless (repos = repositories(username)).empty?
      [].tap do |commits|
        repos.each do |repo|
          commits.concat JSON.to_ostruct(self.class.get("/commits/list/#{username}/#{repo.name}/#{branch}").body).commits
        end
      end
    end
  end
end
