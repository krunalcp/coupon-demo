class EmployeeOtp < ApplicationRecord

  #
  ## Associations
  #
  belongs_to(
    :employee
  )

  #
  ## Validations
  #
  validates(
    :email,
    format: {
      with: EMAIL_REGEX
    },
    presence: true,
    uniqueness: true,
    length: {
      maximum: 50
    }
  )
  validates(
    :otp,
    presence: true,
    length: {
      maximum: 6
    }
  )
end
