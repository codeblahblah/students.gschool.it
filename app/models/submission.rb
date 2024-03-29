class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise

  validates :user, :exercise, :github_repo_name, presence: true
  validates :github_repo_name, format: { with: /\A[^\/]*\z/, message: "Repo name cannot contain slashes" }

  def user_name
    user.full_name
  end

  def github_repo_url
    "https://github.com/#{user.github_username}/#{github_repo_name}"
  end
end
