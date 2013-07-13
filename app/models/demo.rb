class Demo < ActiveRecord::Base
  attr_accessible :name,:organization,:title,:email,:phone,:organization_type,:organization_size,:current_lms
  validates_presence_of :name ,:email,:organization
  validates_length_of :name, :maximum => 30
  validates_uniqueness_of :email, :case_sensitive => false
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_format_of :email, :with => VALID_EMAIL_REGEX,
                      :message => "Invalid Email"
  validates_length_of :organization, :minimum => 3
  validates_length_of :organization,:maximum => 20

end
