class CourseDescription < ActiveRecord::Base
  attr_accessible :course_id,:account_id,:course_description
  belongs_to :course
  belongs_to :account
  validates_presence_of :course_id,:presence =>true
  validates_presence_of :account_id,:presence =>true
  validates_presence_of :course_description, :presence =>true

end
