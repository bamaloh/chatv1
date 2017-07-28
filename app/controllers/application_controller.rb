class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_user
  def check_user
    if cookies["user_id"].present?
      if cookies["Chat_Session_id"].nil?
        p "cookie is not present"
        @Chat_Session = Chat_Session.new
        @Chat_Session.save!
        @Chat_Session.id
        cookies["Chat_Session_id"] = @Chat_Session.id
        p @Chat_Session.id
          p "cookie is not present"
      end
    else
      @user = User.new
      @user.save
      @user.id

      cookies["user_id"] = @user.id

      @Chat_Session = Chat_Session.new
      @Chat_Session.save
      @Chat_Session.id

      cookies["Chat_Session_id"] = @Chat_Session.id
    end
  end

  def reset
  cookies.delete :Chat_Session_id
  redirect_to chat_path
  end
end
