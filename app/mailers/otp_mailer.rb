class OtpMailer < ApplicationMailer
  def otp_send(email)
    @email = email
    mail(
      to: @email.try(:email),
      subject: 'OTP to verify your email.'
    )
  end
end
