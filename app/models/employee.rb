class Employee < ApplicationRecord
  #
  ## Associations
  #
  belongs_to(
    :company
  )
  has_many(
    :employee_coupons,
    dependent: :destroy
  )
  has_one(
    :employee_otp,
    dependent: :destroy
  )

  #
  ## Validations
  #
  validates(
    :prefix,
    presence: true,
    length: {
      maximum: 4
    }
  )
  validates(
    :middle_name,
    presence: true,
    length: {
      maximum: 50
    }
  )
  validates(
    :first_name,
    presence: true,
    length: {
      maximum: 50
    }
  )
  validates(
    :last_name,
    presence: true,
    length: {
      maximum: 50
    }
  )
  validates(
    :company_id,
    presence: true
  )
  validates(
    :email,
    format: {
      with: EMAIL_REGEX
    },
    presence: true
  )
  validates(
    :contact_number,
    numericality: true,
    presence: true,
    length: {
      maximum: 20
    }
  )

  #
  ## Callbacks
  #
  before_validation :assign_company, :validate_email

  #
  ## Assign Coupon to Employee
  #
  def assign_coupon
    date = DateTime.now
    success = nil
    unless self.disabled
      company_coupon =  CompanyCoupon.where(
                          "company_id = ? and start_date <= ? and end_date >= ?",
                          self.company_id,
                          date,
                          date
                        ).first

      if !company_coupon.blank? && company_coupon.number_of_coupon > 0
        rule = CompanyCouponRule.find_by_company_coupon_id(company_coupon.id)
        unless rule.blank?

          employee_coupan_ids = EmployeeCoupon.all.pluck(:coupon_id)
          coupon = Coupon.where.not(id: employee_coupan_ids).first
          employee_coupons = self.employee_coupons.where(company_coupon_id: company_coupon.id).order(:created_at)
          create_coupon = false

          if coupon.blank?
            create_coupon = false
          elsif employee_coupons.blank?
            create_coupon = true
          elsif rule.allowed_coupon == -1 && rule.duration == -1
            create_coupon = true
          elsif rule.allowed_coupon == -1 && rule.duration != -1
            duration = Employee.get_day_duration(employee_coupons.first.created_at.to_date)
            create_coupon = ( duration < rule.duration )
          elsif rule.allowed_coupon != -1 && rule.duration == -1
            create_coupon = ( employee_coupons.count < rule.allowed_coupon )
          elsif rule.allowed_coupon != -1 && rule.duration != -1
            duration = Employee.get_day_duration(employee_coupons.first.created_at.to_date)
            create_coupon = ( employee_coupons.count < rule.allowed_coupon && duration < rule.duration )
          end

          if create_coupon
            self.employee_coupons.create(coupon_id: coupon.id, company_coupon_id: company_coupon.id)
            company_coupon.update_column(:number_of_coupon, company_coupon.number_of_coupon - 1)
            success = true
          else
            success = false
          end
        end
      end
    end
    success
  end

  #
  ## full name of employee
  #
  def name
    [prefix, first_name, middle_name, last_name].compact.join(' ')
  end

  private
  #
  ## Validate Email is Verified or not?
  #
  def validate_email
    if self.new_record?
      email_record = Email.find_by(email: self.email, verified: true)
      if email_record.blank?
        errors.add(:email, 'Email is not verified.')
      end
    end
  end

  #
  ## Assign company id
  #
  def assign_company
    if self.new_record?
      unless email.blank?
        domain = email.split('@')
        company_domain = Company.find_by(domain: domain[1])
        unless company_domain.blank?
          company_id = company_domain.id
        else
          errors.add(:email, "Please enter valid email.")
        end
      end
    end
  end

  #
  ## Find Duration between two date
  #
  def self.get_day_duration(start_date, end_date = Date.today)
    unless start_date.blank? && end_date.blank?
      (start_date - end_date).to_i.abs
    end
  end
end
