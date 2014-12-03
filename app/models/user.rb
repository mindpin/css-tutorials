class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :uid,          type: String
  field :name,         type: String
  field :avatar,       type: String
  field :access_token, type: String
  field :expires_in,   type: String

end
