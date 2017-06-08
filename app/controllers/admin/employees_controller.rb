class Admin::EmployeesController < Admin::AdminController

  #
  ## Before action callbacks
  #
  before_action(
    :set_employee,
    only: [
      :show,
      :edit,
      :update,
      :destroy
    ]
  )

  #
  ## For employee
  #
  def index
    @per_page   = (params[:per_page].blank? ? PER_PAGE : params[:per_page])
    @employees  = Employee.all.page(params[:page]).per(@per_page)
  end

  #
  ## show method employee
  #
  def show
  end

  #
  ## new method employee
  #
  def new
    @employee = Employee.new
  end

  #
  ## edit method employee
  #
  def edit
  end

  #
  ## create method employee
  #
  def create
    @employee = Employee.new(employee_params)
    respond_to do |format|
      if @employee.save
        format.html {
          flash[:success] = 'employee was successfully created.'
          redirect_to admin_employee_path(@employee)
        }
        format.json {
          render(
            :show,
            status: :created,
            location: @employee
          )
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

  #
  ## update method employee
  #
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html {
          flash[:success] = 'employee was successfully updated.'
          redirect_to admin_employee_path(@employee)
        }
        format.json {
          render(
            :show,
            status: :ok,
            location: @employee
          )
        }
      else
        format.html {
          flash[:alert] = 'Please fill correct data.'
          render :edit
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

  #
  ## destroy method employee
  #
  def destroy
    data = @employee.disabled == true ? false : true
    @employee.update(disabled: data)
    respond_to do |format|
      format.html {
        flash[:delete] = 'employee was successfully destroyed.'
        redirect_to admin_employees_path
      }
      format.json { head :no_content }
    end
  end


  private
  #
  ## set employee id before show, edit, update and destroy methods
  #
  def set_employee
    @employee = Employee.find_by_id(params[:id])
    redirect_to admin_employees_path if @employee.blank?
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
