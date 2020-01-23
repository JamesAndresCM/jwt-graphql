class User < ApplicationRecord 
  include Devise::JWT::RevocationStrategies::JTIMatcher
  include Tokenizable
  belongs_to :account, inverse_of: :users, touch: true
  validates :account_id, presence: true

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :devise,
         :validatable,
         :trackable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self
  enum role: %i[user admin]

  validates :email, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :first_name, length: { maximum: 255 }
  validates :last_name, presence: true
  validates :last_name, length: { maximum: 255 }
  validates :password_confirmation, presence: true, on: %i[update create]

  after_initialize :setup_new_user, if: :new_record?

  # Send mail through sidekiq
  def send_devise_notification(_notification, *_args)
    NotificationWorker.perform_async(email, reset_password_token)
  end

  def name
    [first_name, last_name].join(' ').strip
  end

  private

  def setup_new_user
    self.role ||= :user
  end
end
