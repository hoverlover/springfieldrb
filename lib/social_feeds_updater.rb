require 'github_api'

class SocialFeedsUpdater
  include GitHubAPI
  COMMIT_LIMIT = 20

  def update
    Member.github_members.each do |member|
      username = member.github_username
      REDIS.set "repositories:#{username}", YAML::dump(repositories(username))
      REDIS.set "commits:#{username}", YAML::dump(user_commits(username))
    end
  end

private
  def user_commits(username)
    page = 0
    [].tap do |commits|
      while (page_commits = page_of_commits(username, page += 1)).size > 0 do
        commits.concat page_commits
        break if commits.size >= COMMIT_LIMIT
      end
    end
  end

  def page_of_commits(username, page)
    commits(username, 'master', page).select { |commit| commit.author.login == username }
  end
end
