class Admin::CompanyCouponsController < Admin::AdminController

  #
  ## Before action callbacks
  #
  before_action(
    :set_company_coupon,
    only: [
      :show,
      :edit,
      :update,
      :destroy
    ]
  )

  #
  ## For Company Coupon
  #
  def index
    @per_page         = (params[:per_page].blank? ? PER_PAGE : params[:per_page])
    @company_coupons  = CompanyCoupon.includes(
                          :company
                        ).all.page(params[:page]).per(@per_page)
  end

  #
  ## show method status_types
  #
  def show
  end

  #
  ## new method Company Coupon
  #
  def new
    @company_coupon = CompanyCoupon.new
  end

  #
  ## edit method Company Coupon
  #
  def edit
  end

  #
  ## create method Company Coupon
  #
  def create
    @company_coupon = CompanyCoupon.new(company_coupon_params)
    respond_to do |format|
      if @company_coupon.save
        CompanyCouponRule.create_company_coupon_rule(
          @company_coupon.id,
          params[:company_coupon_rule]
        )
        format.html {
          flash[:success] = 'Company Coupon was successfully created.'
          redirect_to admin_company_coupon_path(@company_coupon)
        }
        format.json {
          render(
            :show,
            status: :created,
            location: @company_coupon
          )
        }
      else
        format.html {
          flash[:alert] = 'Please fill correct data.'
          render :new
        }
        format.json {
          render(
            json: @company_coupon.errors,
            status: :unprocessable_entity
          )
        }
      end
    end
  end

  #
  ## update method Company Coupon
  #
  def update
    respond_to do |format|
      if @company_coupon.update(company_coupon_params)
        format.html {
          flash[:success] = 'Company Coupon was successfully updated.'
          redirect_to admin_company_coupon_path(@company_coupon)
        }
        format.json {
          render(
            :show,
            status: :ok,
            location: @company_coupon
          )
        }
      else
        format.html {
          flash[:alert] = 'Please fill correct data.'
          render :edit
        }
        format.json {
          render(
            json: @company_coupon.errors,
            status: :unprocessable_entity
          )
        }
      end
    end
  end

  #
  ## destroy method Company Coupon
  #
  def destroy
    @company_coupon.destroy
    respond_to do |format|
      format.html {
        flash[:delete] = 'Company Coupon was successfully destroyed.'
        redirect_to admin_company_coupons_path
      }
      format.json { head :no_content }
    end
  end


  private
  #
  ## set Company Coupon id before show, edit, update and destroy methods
  #
  def set_company_coupon
    @company_coupon = CompanyCoupon.find_by_id(params[:id])
    redirect_to admin_company_coupons_path if @company_coupon.blank?
  end

  #
  ## Company Coupon params
  #
  def company_coupon_params
    params.require(:company_coupon).permit(
      :company_id,
      :number_of_coupon,
      :start_date,
      :end_date,
      company_coupon_rules_attributes: [
        :id,
        :company_id,
        :allowed_coupon,
        :time_duration,
        :_destroy
      ]
    )
  end
end
