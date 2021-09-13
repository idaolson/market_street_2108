class Apartment
  attr_reader :number, :monthly_rent, :bathrooms, :bedrooms, :renter
  def initialize(params)
    @number = params[:number]
    @monthly_rent = params[:monthly_rent]
    @bathrooms = params[:bathrooms]
    @bedrooms = params[:bedrooms] 
  end

  def add_renter(renter)
    @renter = renter
  end

  def rented?
    @renter != nil
  end
end
