class Notification < ActionMailer::Base
  default from: "from@example.com"

  def send_confirmation_email(user)
  	@user = user
  	mail to: user.email,
  	     subject: 'Confirmation Instruction'
  end
end
