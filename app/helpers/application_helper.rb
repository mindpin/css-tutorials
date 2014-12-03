module ApplicationHelper
  def current_user
    return if !user_id
    User.where(id: user_id).first
  end

  def set_current_user!(user)
    cookies.permanent.signed["user_id"] = user.id.to_s
  end

  def signed_in?
    !current_user.blank?
  end

  def logout!
    cookies.delete "user_id"
  end

  private
    def user_id
      cookies.signed["user_id"]
    end
end
