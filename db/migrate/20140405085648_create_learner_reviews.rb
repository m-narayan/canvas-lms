class CreateLearnerReviews < ActiveRecord::Migration
  def self.up
    create_table :learner_reviews do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :learner_reviews
  end
end
