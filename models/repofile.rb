class Repofile < Sequel::Model

  many_to_one :repo

  include Redis::Objects
  include Serializable
  include StandardModel

  self._readable = [:id, :created_at, :updated_at, :filename, :repo_id, :content]
  self._writable = [:contents, :filename]

  def authorized?(_access_token)
    return true if _access_token == self.repo.user.auth_token
    false
  end

  def self.content=(data)
    gh = Github.client(self.repo.user.auth_token)
    
  end

  def content
    gh = Github.client(self.repo.user.auth_token)
    gh_content = gh.contents(repo_name, :path => self.filename, :ref => 'gh-pages')
    Base64.decode64(gh_content.content)
  end

  def repo_name
    "#{self.repo.user.username}/#{self.repo.name}"
  end

end
