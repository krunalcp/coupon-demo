class Admin::CouponsController < Admin::AdminController

  #
  ## Before action callbacks
  #
  before_action(
    :set_coupon,
    only: [
      :show,
      :edit,
      :update,
      :destroy
    ]
  )

  #
  ## For Coupon
  #
  def index
    @per_page = (params[:per_page].blank? ? PER_PAGE : params[:per_page])
    @coupons  = Coupon.all.page(params[:page]).per(@per_page)
  end

  #
  ## show method Coupon
  #
  def show
  end

  #
  ## new method Coupon
  #
  def new
    @coupon = Coupon.new
  end

  #
  ## edit method Coupon
  #
  def edit
  end

  #
  ## create method Coupon
  #
  def create
    @coupon = Coupon.new(coupon_params)
    respond_to do |format|
      if @coupon.save
        format.html {
          flash[:success] = 'Coupon was successfully created.'
          redirect_to admin_coupon_path(@coupon)
        }
        format.json {
          render(
            :show,
            status: :created,
            location: @coupon
          )
        }
      else
        format.html {
          flash[:alert] = 'Please fill correct data.'
          render :new
        }
        format.json {
          render(
            json: @coupon.errors,
            status: :unprocessable_entity
          )
        }
      end
    end
  end

  #
  ## update method Coupon
  #
  def update
    respond_to do |format|
      if @coupon.update(coupon_params)
        format.html {
          flash[:success] = 'Coupon was successfully updated.'
          redirect_to admin_coupon_path(@coupon)
        }
        format.json {
          render(
            :show,
            status: :ok,
            location: @coupon
          )
        }
      else
        format.html {
          flash[:alert] = 'Please fill correct data.'
          render :edit
        }
        format.json {
          render(
            json: @coupon.errors,
            status: :unprocessable_entity
          )
        }
      end
    end
  end

  #
  ## destroy method Coupon
  #
  def destroy
    @coupon.destroy
    respond_to do |format|
      format.html {
        flash[:delete] = 'Coupon was successfully destroyed.'
        redirect_to admin_coupons_path
      }
      format.json { head :no_content }
    end
  end

  def import_coupons
  end

  #
  ## create import Coupons record
  #
  def create_import_coupons
    file = params[:file]
    unless file.blank?
      spreadsheet = open_file(file)
      header      = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        if !row["Code"].blank? && !row["Expiry Date"].blank?
          coupon = Coupon.new(
            code: row["Code"],
            expiry_date: row["Expiry Date"],
            description: row["Description"],
            vendor: row["Vendor"]
          )
          coupon.save
        end
      end
      flash[:success] = 'Import coupon was successfully created.'
      redirect_to admin_coupons_path
    else
      flash[:alert] = 'Import coupon File not found.'
      redirect_to admin_coupons_path
    end
  end

  #
  ## open file
  #
  def open_file(file)
    begin
      case File.extname(file.original_filename)
      when ".xls" then Roo::Excel.new(file.path)
      when ".xlsx" then Roo::Excelx.new(file.path)
      else raise "Unknown file type: #{file.original_filename}"
      end
    rescue Exception => e
      logger.info e
    end
  end

  private
  #
  ## set Coupon id before show, edit, update and destroy methods
  #
  def set_coupon
    @coupon = Coupon.find_by_id(params[:id])
    redirect_to admin_coupons_path if @coupon.blank?
  end

  #
  ## Coupon params
  #
  def coupon_params
    params.require(:coupon).permit(
      :code,
      :expiry_date,
      :description,
      :vendor
    )
  end
end
