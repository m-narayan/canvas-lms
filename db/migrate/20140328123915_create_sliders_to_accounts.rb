class CreateSlidersToAccounts < ActiveRecord::Migration
  tag :postdeploy
  def self.up
    create_table :account_sliders do |t|
      t.string :slider_image_url
      t.string :slider_back_ground_image_url
      t.string :header_text
      t.string :body_content
      t.integer :account_id,:limit => 8
      t.timestamps

    end
  end

  def self.down
    drop_table :account_sliders
  end
end
