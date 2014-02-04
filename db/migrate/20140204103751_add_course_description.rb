class AddCourseDescription < ActiveRecord::Migration
  tag :predeploy
  def self.up
     add_column :courses, :description, :text
  end

  def self.down
     add_column :courses, :description
  end
end
