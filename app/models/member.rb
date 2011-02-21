class Member < ActiveRecord::Base

  scope :github_members, where('github_username is not null')

  def full_name
    [first_name, last_name].compact.join ' '
  end

  def github_commits
    return [] unless (commits = REDIS.get("commits:#{github_username}")).present?
    YAML::load(commits)
  end

  def github_repos
    return [] unless (repos = REDIS.get("repositories:#{github_username}")).present?
    YAML::load(repos)
  end
end
