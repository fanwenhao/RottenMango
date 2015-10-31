class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://www.gmail.com'
    mail(to: @user.email,
         subject: 'Welcome to My Awesome Site',
         template_path: 'user_mailer',
         template_name: 'welcome_email')
  end

  def delete_email(user)
    @user = user
    @url  = 'http://www.gmail.com'
    mail(to: @user.email,
         subject: 'Your Account has been deleted!',
         template_path: 'user_mailer',
         template_name: 'delete_email')
  end

end
