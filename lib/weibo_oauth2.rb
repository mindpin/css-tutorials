class WeiboOauth2
  AUTHORIZE_URL    = "https://api.weibo.com/oauth2/authorize"
  ACCESS_TOKEN_URL = "https://api.weibo.com/oauth2/access_token"
  def initialize(key, secret, callback_url)
    @key = key
    @secret = secret
    @callback_url = callback_url
  end

  def authorize_url
    "#{AUTHORIZE_URL}?client_id=#{@key}&redirect_uri=#{@callback_url}"
  end

  def get_access_info(code)
    url_params = {
      :client_id => @key,
      :client_secret => @secret,
      :grant_type => 'authorization_code',
      :code => code,
      :redirect_uri => @callback_url
    }
    response = Net::HTTP.post_form(URI.parse(ACCESS_TOKEN_URL), url_params)
    body = JSON.parse(response.body)
    access_info_struct = Struct.new(:uid, :access_token, :expires_in, :remind_in)
    @access_info              = access_info_struct.new
    @access_info.uid          = body["uid"]
    @access_info.access_token = body["access_token"]
    @access_info.expires_in   = body["expires_in"]
    @access_info.remind_in    = body["remind_in"]
    @access_info
  end

  def get_auth_user_info
    user_show_url = "https://api.weibo.com/2/users/show.json?access_token=#{@access_info.access_token}&uid=#{@access_info.uid}"
    response = Net::HTTP.get_response(URI.parse(user_show_url))
    body = JSON.parse(response.body)
    auth_user_info_struct = Struct.new(:name, :avatar_hd)
    @auth_user_info           = auth_user_info_struct.new
    @auth_user_info.name      = body["name"]
    @auth_user_info.avatar_hd = body["avatar_hd"]
    @auth_user_info
  end
end