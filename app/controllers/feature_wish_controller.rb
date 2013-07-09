class FeatureWishController < ApplicationController
  def create
   @feature_wish = FeatureWish.create(:account_name => @current_user.account.name,:user_name => @current_user.name,
                                      :unique_id => @current_user.pseudonym.unique_id,:feature_clicked => params[:action],
                                      :clicked_at => Time.now)
    @feature_wish.save!
  end

  def update
    @feature_wish = FeatureWish.find
  end
end
