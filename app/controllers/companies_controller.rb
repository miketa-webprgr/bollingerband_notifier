class CompaniesController < ApplicationController
  # GET /companies
  def index
    @companies = Company.all
  end

  # GET /companies/1
  def show
    @company = Company.find(params[:id])
    @company.prices.each do |price|
      price.assign_attributes(
        up_band: price.upper_band,
        dn_band: price.down_band,
        sd: price.standard_deviation,
        avg: price.average_price,
        too_old_flag: price.too_old?
      )
    end
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # POST /companies
  def create
    @company = Company.new(company_params)

    if @company.save
      @search = @company.create_search
      redirect_to @company, notice: 'Company was successfully created.'
    else
      render :new
    end
  end

  # DELETE /companies/1
  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    redirect_to companies_url, notice: 'Company was successfully destroyed.'
  end

  private
    # Only allow a list of trusted parameters through.
    def company_params
      params.require(:company).permit(:symbol, :name)
    end
end
