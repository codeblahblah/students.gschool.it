class SessionsController < ApplicationController
  def create
    user_info = request.env['omniauth.auth']['info']

    render :text => "Email: #{user_info['email']}, Nickname: #{user_info['nickname']}"
  end

  def failure
    render :text => request.env['omniauth.auth'].inspect
  end
end