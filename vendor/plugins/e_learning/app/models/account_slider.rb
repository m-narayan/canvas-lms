class AccountSlider < ActiveRecord::Base
  belongs_to :account
  attr_accessible :account_id,:account_slider_url
end
