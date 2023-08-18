class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:login]

  validates :username, presence: true, uniqueness: true

  attr_accessor :login
  attr_accessor :login_type

  has_many :posts

  def login
    @login || self.username || self.email
  end

  # Virtual attribute for authenticating by either username or email
  # This will be used in the Devise authentication process
  # def self.find_for_database_authentication(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login_type = conditions.delete(:login_type)
  #     if login_type == 'email'
  #       where(conditions.to_h).first
  #     elsif login_type == 'username'
  #       where(conditions.to_h).where(["lower(username) = :value", { :value => conditions[:value].downcase }]).first
  #     end
  #   elsif conditions.has_key?(:email) || conditions.has_key?(:username)
  #     where(conditions.to_h).first
  #   end
  # end

  private

  def self.find_for_database_authentication(warden_condition)
    conditions = warden_condition.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end
