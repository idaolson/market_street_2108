class Building
  attr_reader :units

  def initialize
    @units = []
  end

  def add_unit(unit)
    @units << unit
  end

  def renters
    renters = []
    @units.each do |unit|
      if unit.rented?
        renters << unit.renter.name
      end
    end
    renters
  end

  def average_rent
    total_rent = @units.sum do |unit|
      unit.monthly_rent
    end.to_f

    total_rent / @units.count
  end

  def rented_units
    @units.find_all do |unit|
      if unit.rented?
        unit
      end
    end
  end

  def renter_with_highest_rent
    highest = rented_units.max_by do |unit|
      unit.monthly_rent
    end

    highest.renter
  end

  def units_by_number_of_bedrooms
    number_of_beds = Hash.new
    @units.each do |unit|
      if number_of_beds.keys.include?(unit.bedrooms)
        number_of_beds[unit.bedrooms] << unit.number
      else
        number_of_beds[unit.bedrooms] = [unit.number]
      end
    end
    number_of_beds
  end

  def annual_breakdown
    breakdown = Hash.new
    rented_units.each do |unit|
      breakdown[unit.renter.name] = (unit.monthly_rent * 12)
    end
    breakdown
  end

  def rooms_by_renter
    by_renter = {}
    rented_units.each do |unit|
      by_renter[unit.renter] = {bathrooms: unit.bathrooms,
                                bedrooms: unit.bedrooms}
    end
    by_renter
  end
end
