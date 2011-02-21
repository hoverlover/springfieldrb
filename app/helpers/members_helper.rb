module MembersHelper
  def repo_name_from_commit_url(url)
    url.split('/').delete_if(&:empty?).second
  end

  def short_sha(commit_id)
    commit_id.first(7)
  end
end
