class UserMailer < ApplicationMailer
  default from: 'No reply <test@domain.com>'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user_email, user_reset_token)
    @user_email = user_email
    @user_reset_token = user_reset_token
    mail to: @user_email, subject: 'Password Reset'
  end
end
