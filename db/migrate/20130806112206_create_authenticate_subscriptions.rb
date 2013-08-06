class CreateAuthenticateSubscriptions < ActiveRecord::Migration
  tag :predeploy
  def self.up
    create_table :authenticate_subscriptions do |t|
      t.string :unique_id
      t.string :password
      t.string :account_name
      t.text :token
      t.timestamps
    end
  end

  def self.down
    drop_table :authenticate_subscriptions
  end
end
