class CssTutorial
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,      type: String
  field :tid,        type: String
  field :html,       type: String
  field :css,        type: String
  field :check_data, type: String
  field :tips_data,  type: String

  has_one :minicourse, :class_name => "EduGameMap::Minicourse"
end
