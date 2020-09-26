class SearchesController < ApplicationController
  def update
    @company = Company.find(params[:company_id])
    @company.search.update(search_params)
    @company.prices.each do |price|
      price.assign_attributes(
        up_band: price.upper_band,
        dn_band: price.down_band,
        sd: price.standard_deviation,
        avg: price.average,
        too_old_flag: price.too_old?
      )
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def search_params
      params.require(:search).permit(:sigma, :mv_period)
    end
end
