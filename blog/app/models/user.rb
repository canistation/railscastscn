class User < ActiveRecord::Base
  validates :nickname, :presence => true
  validates :email, :presence => true, :uniqueness => true
  has_many :authentications

  accepts_nested_attributes_for :authentications

  def add_auth(auth)
    authentications.create(:provider => auth[:provider],
                           :uid => auth[:uid]
                          )
  end

  class << self
    def from_auth(auth)
      lookup_auth(auth) || lookup_email(auth) || create_user_with_auth(auth)
    end

    def lookup_auth(auth)
      Authentication.find_by_provider_and_uid(auth[:provider], auth[:uid]).try(:user)
    end

    def lookup_email(auth)
      user = find_by_email(auth[:info][:email])
      return unless user
      user.add_auth(auth)
      user
    end

    def create_user_with_auth(auth)
      create!(
        :nickname => auth[:info][:nickname],
        :email => auth[:info][:email],
        :authentications_attributes => [
          Authentication.new(:provider => auth[:provider],
                             :uid => auth[:uid]
                            ).attributes
      ])
    end
  end
end
