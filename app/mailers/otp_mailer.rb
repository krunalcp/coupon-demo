class OtpMailer < ApplicationMailer
  default from: 'maulik@softices.com'

  def otp_send(email)
    @email = email
    mail(
      to: @email.try(:email),
      subject: 'Otp Send'
    )
  end

end
