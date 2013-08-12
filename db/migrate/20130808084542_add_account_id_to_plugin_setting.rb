class AddAccountIdToPluginSetting < ActiveRecord::Migration
  tag :predeploy
  def self.up
    add_column :plugin_settings, :account_id ,:integer,:limit => 8
  end

  def self.down
    remove_column :plugin_settings , :account_id
  end
end
