class NotificationWorker
  include Sidekiq::Worker

  def perform(user_email, user_reset_token)
    UserMailer.password_reset(user_email, user_reset_token).deliver_now
  end
end
