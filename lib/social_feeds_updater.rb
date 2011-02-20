require 'github_api'
include GitHubAPI

class SocialFeedsUpdater

  def self.update
    Member.github_members.each do |member|
      REDIS.set "repositories:#{member.github_username}", repositories(member.github_username).to_yaml
      REDIS.set "commits:#{member.github_username}", commits(member.github_username).to_yaml
    end
  end
end
