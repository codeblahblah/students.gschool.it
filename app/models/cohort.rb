class Cohort < ActiveRecord::Base
  validates :name, :directions, :google_maps_location, presence: true

  has_many :cohort_assignments
  has_many :assignments, through: :cohort_assignments
  has_many :users

  def students
    users.where.not(role_bit_mask: User::INSTRUCTOR)
  end
end
