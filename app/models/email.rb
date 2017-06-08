class Email < ApplicationRecord
  #
  ## Call back
  #
  after_save :send_mail_to_employee

  #
  ## Validation
  #
  validates(
    :email,
    presence: true
  )
  validates(
    :otp,
    presence: true
  )

  #
  ## otp mail send to employee
  #
  def send_mail_to_employee
    OtpMailer.otp_send(self).deliver
  end
end
