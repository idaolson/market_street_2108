require './lib/renter'
require './lib/apartment'
require './lib/building'

RSpec.describe Building do
  before :each do
    @building = Building.new
    @unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    @unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})
    @renter1 = Renter.new("Aurora")
    @renter2 = Renter.new("Tim")
  end

  it "exists" do
    expect(@building).to be_a(Building)
  end

  it "adds units" do
    expect(@building.units).to eq([])
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    expect(@building.units).to eq([@unit1, @unit2])
  end

  it "has an array of renter names for all units" do
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    expect(@building.renters).to eq([])
    @unit1.add_renter(@renter1)
    expect(@building.renters).to eq(["Aurora"])
    @unit2.add_renter(@renter2)
    expect(@building.renters).to eq(["Aurora", "Tim"])
  end

  it "averages the rent of the units in the building" do
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    expect(@building.average_rent).to eq(1099.5)
  end

  context "iteration 3" do
    building = Building.new
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 1, bedrooms: 2})
    unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})
    unit4 = Apartment.new({number: "D4", monthly_rent: 1500, bathrooms: 2, bedrooms: 3})
    renter1 = Renter.new("Spencer")
    renter2 = Renter.new("Jessie")
    renter3 = Renter.new("Max")
    building.add_unit(unit1)
    building.add_unit(unit2)
    building.add_unit(unit3)
    building.add_unit(unit4)

    it "returns an array of units in building with a renter" do
      expect(building.rented_units).to eq([])
      unit2.add_renter(renter1)
      expect(building.rented_units).to eq([unit2])
    end

    it "returns the renter with the highest rent" do
      expect(building.renter_with_highest_rent).to eq(renter1)
      unit1.add_renter(renter2)
      expect(building.renter_with_highest_rent).to eq(renter2)
      unit3.add_renter(renter3)
      expect(building.renter_with_highest_rent).to eq(renter2)
    end

    it "sorts the units into a hash with number of rooms and number" do
      result = {
        3 => ["D4" ],
        2 => ["B2", "C3"],
        1 => ["A1"]
      }
      expect(building.units_by_number_of_bedrooms).to eq(result)
    end
  end

  context "iteration 4" do
    building = Building.new
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})
    unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})
    renter1 = Renter.new("Spencer")
    renter2 = Renter.new("Jessie")
    building.add_unit(unit1)
    building.add_unit(unit2)
    building.add_unit(unit3)

    it "calculates the rent each renter pays for an entire year" do
      unit2.add_renter(renter1)
      expect(building.annual_breakdown).to eq({"Spencer" => 11988})
      unit1.add_renter(renter2)
      expect(building.annual_breakdown).to eq({"Jessie" => 14400, "Spencer" => 11988})
    end

    it "returns a hash of bedrooms and bathrooms by renter" do
      expected = {renter2 => {bathrooms: 1, bedrooms: 1},
                  renter1 => {bathrooms: 2, bedrooms: 2}}
      expect(building.rooms_by_renter).to eq(expected)
    end
  end
end
