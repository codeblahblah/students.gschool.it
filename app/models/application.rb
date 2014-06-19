class Application < ActiveRecord::Base
  mount_uploader :resume, ResumeUploader
  belongs_to :job_opportunity
  belongs_to :user
end
