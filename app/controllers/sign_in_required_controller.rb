class SignInRequiredController < ApplicationController
  include UserSessionHelper

  before_action :require_signed_in_user

  around_filter :user_time_zone

  private

  def user_time_zone(&block)
    Time.use_zone(Rails.application.config.time_zone, &block)
  end
end