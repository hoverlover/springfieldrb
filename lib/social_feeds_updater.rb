require 'github_api'

class SocialFeedsUpdater
  include GitHubAPI

  def update
    Member.github_members.each do |member|
      REDIS.set "repositories:#{member.github_username}", YAML::dump(repositories(member.github_username))
      REDIS.set "commits:#{member.github_username}", YAML::dump(commits(member.github_username))
    end
  end
end
