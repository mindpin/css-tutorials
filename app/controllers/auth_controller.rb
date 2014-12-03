class AuthController < ApplicationController
  def new
  end

  def weibo
    weibo_oauth2 = WeiboOauth2.new(R::WEIBO_APP_KEY, R::WEIBO_APP_SECRET, R::WEIBO_APP_CALLBACK_URL)
    redirect_to weibo_oauth2.authorize_url
  end

  def callback
    weibo_oauth2 = WeiboOauth2.new(R::WEIBO_APP_KEY, R::WEIBO_APP_SECRET, R::WEIBO_APP_CALLBACK_URL)
    access_info    = weibo_oauth2.get_access_info(params[:code])
    auth_user_info = weibo_oauth2.get_auth_user_info

    user = User.find_or_initialize_by(uid: access_info.uid)
    user.update_attributes(
      :name         => auth_user_info.name,
      :avatar       => auth_user_info.avatar_hd,
      :access_token => access_info.access_token,
      :expires_in   => access_info.expires_in,
    )
    set_current_user!(user)
    redirect_to "/"
  end

  def destroy
    logout!
    redirect_to "/"
  end
end