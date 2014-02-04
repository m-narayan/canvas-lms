class AddImagestocourses < ActiveRecord::Migration
  tag :postdeploy
  def self.up
    add_column :courses, :image_url, :string
    add_column :courses, :back_ground_image_url, :string
  end

  def self.down
    remove_column :courses, :image_url
    remove_column :courses, :back_ground_image_url
  end
end
