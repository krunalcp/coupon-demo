class Admin::CompaniesController < Admin::AdminController

  #
  ## Before action callbacks
  #
  before_action(
    :set_company,
    only: [
      :show,
      :edit,
      :update,
      :destroy
    ]
  )

  #
  ## For Company
  #
  def index
    @companies  = Company.all.page(@page).per(@per_page)
  end

  #
  ## show method Company
  #
  def show
  end

  #
  ## new method Company
  #
  def new
    @company = Company.new
  end

  #
  ## edit method Company
  #
  def edit
  end

  #
  ## create method Company
  #
  def create
    @company = Company.new(company_params)
    respond_to do |format|
      if @company.save
        format.html {
          flash[:success] = 'Company was successfully created.'
          redirect_to [:admin, @company]
        }
        format.json {
          render(
            :show,
            status: :created,
            location: [:admin, @company]
          )
        }
      else
        format.html {
          flash[:alert] = 'Please fill correct data.'
          render :new
        }
        format.json {
          render(
            json: @company.errors,
            status: :unprocessable_entity
          )
        }
      end
    end
  end

  #
  ## update method Company
  #
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html {
          flash[:success] = 'Company was successfully updated.'
          redirect_to [:admin, @company]
        }
        format.json {
          render(
            :show,
            status: :ok,
            location: [:admin, @company]
          )
        }
      else
        format.html {
          flash[:alert] = 'Please fill correct data.'
          render :edit
        }
        format.json {
          render(
            json: @company.errors,
            status: :unprocessable_entity
          )
        }
      end
    end
  end

  #
  ## destroy method Company
  #
  def destroy
    @company.destroy
    respond_to do |format|
      format.html {
        flash[:delete] = 'Company was successfully destroyed.'
        redirect_to admin_companies_path
      }
      format.json { head :no_content }
    end
  end


  private
  #
  ## set Company id before show, edit, update and destroy methods
  #
  def set_company
    @company = Company.find_by_id(params[:id])
    redirect_to admin_companies_path if @company.blank?
  end

  #
  ## Company params
  #
  def company_params
    params.require(:company).permit(
      :name,
      :address,
      :email,
      :contact_number,
      :domain
    )
  end
end
