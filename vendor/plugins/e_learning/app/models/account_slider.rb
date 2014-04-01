class AccountSlider < ActiveRecord::Base
  attr_accessible :slider_image_url,:slider_back_ground_image_url,:header_text,:body_content,:account_id
  belongs_to :account
end
