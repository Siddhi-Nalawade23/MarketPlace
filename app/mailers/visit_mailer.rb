class VisitMailer < ApplicationMailer
  def daily_thank_you(user)
    @user = user
    mail(
      to: @user.email,
      subject: "Thank you for visiting Marketplace!"
    )
  end
end
