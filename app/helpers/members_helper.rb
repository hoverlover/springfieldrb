module MembersHelper
  def repo_name_from_commit_url(url)
    url.split('/').delete_if(&:empty?).second
  end
end
