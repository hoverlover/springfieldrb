module MembersHelper
  def repo_name_from_commit_url(url)
    url.split('/').delete_if(&:empty?).second
  end

  def short_sha(commit_id)
    commit_id.first(7)
  end

  def sorted_repos(repos, num = repos.size + 1)
    limit(repos.sort { |a,b| a.name <=> b.name }, num)
  end

  def sorted_commits(commits, num = commits.size + 1)
    limit(commits.sort { |a,b| b.committed_date <=> a.committed_date }, num)
  end

private
  def limit(items, num)
    items[0...num]
  end
end
