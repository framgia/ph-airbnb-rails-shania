class ModelMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.model_mailer.new_record_notification.subject
  #

  default from: "railscast@example.com"

  def new_record_notification
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Activate your account.')
  end
end
