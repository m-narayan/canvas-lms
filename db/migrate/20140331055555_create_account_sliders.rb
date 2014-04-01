class CreateAccountSliders < ActiveRecord::Migration
  def self.up
    create_table :account_sliders do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :account_sliders
  end
end
