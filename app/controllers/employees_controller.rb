class EmployeesController < ApplicationController
  layout 'employee'

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.find_or_initialize_by(email: employee_params[:email])
    @employee.assign_attributes(employee_params)
    respond_to do |format|
      if @employee.save
        data = @employee.assign_coupon
        if data
          message = 'Coupon assigned successfully.'
        elsif data == false
          message = 'Coupon already assigned please try after some time.'
        else
          message = 'Employee was successfully created.'
        end
        format.html {
          flash[:success] = message
          redirect_to root_path
        }
      else
        format.html {
          flash[:alert] = 'Please fill correct data.'
          render :new
        }
        format.json {
          render(
            json: @employee.errors,
            status: :unprocessable_entity
          )
        }
      end
    end
  end

  def verify_employee_email
    unless params[:email].blank?
      @email = params[:email]
      email = Email.find_or_initialize_by(
                email: @email,
                verified: false
              )
      otp = rand(0..9999).to_s.rjust(4,'0')
      email.otp = otp
      email.send_date = Time.now
      email.save
    end
    render layout: false
  end

  def email_is_valide
    employee_email = params[:email]
    unless employee_email.blank?
      email = Email.find_by(email: employee_email, verified: true)
      data = false
      if email.blank?
        domain = employee_email.split('@')
        company_domain = Company.find_by(domain: domain[1])
        if company_domain.blank?
          data = false
        else
          data = true
        end
      else
        data = 'available'
      end
    end
    render json: { data: data }
  end

  def check_otp
    status = 404
    unless params[:email].blank? && params[:otp]
      email = Email.find_by(
                email: params[:email],
                otp: params[:otp],
                verified: false
              )
      unless email.blank?
        email.update(verified: true)
        status = 200
      end
    end
    render json: {
      status: status
    }
  end

  private
  #
  ## set employee id before show, edit, update and destroy methods
  #
  def set_employee
    @employee = Employee.find_by_id(params[:id])
    redirect_to employees_path if @employee.blank?
  end

  #
  ## employee params
  #
  def employee_params
    params.require(:employee).permit(
      :prefix,
      :first_name,
      :middle_name,
      :last_name,
      :email,
      :contact_number,
      :address
    )
  end

end