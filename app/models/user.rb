# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  email                        :string           not null
#  crypted_password             :string
#  salt                         :string
#  name                         :string
#  created_at                   :datetime
#  updated_at                   :datetime
#  remember_me_token            :string
#  remember_me_token_expires_at :datetime
#  failed_logins_count          :integer          default("0")
#  lock_expires_at              :datetime
#  unlock_token                 :string
#

class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :email, uniqueness: true, email_format: { message: 'has invalid format' }

  class << self
    def current_users
      where("#{sorcery_config.last_activity_at_attribute_name} IS NOT NULL") \
  .where("#{sorcery_config.last_logout_at_attribute_name} IS NULL
    OR #{sorcery_config.last_activity_at_attribute_name} > #{sorcery_config.last_logout_at_attribute_name}") \
  .where("#{sorcery_config.last_activity_at_attribute_name} > ? ", sorcery_config.activity_timeout.seconds.ago.utc.to_s(:db))
    end
  end
end
