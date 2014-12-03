class CssTutorial
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,  type: String
  field :rule,   type: String
  field :tips,   type: String

  has_one :minicourse, :class_name => "EduGameMap::Minicourse"
end
