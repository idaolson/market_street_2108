require './lib/renter'
require './lib/apartment'

RSpec.describe Apartment do
  before :each do
    @renter1 = Renter.new("Jessie")
    @unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
  end

  it "exists" do
    expect(@unit1).to be_an(Apartment)
  end

  it "has attributes" do
    expect(@unit1.number).to eq("A1")
    expect(@unit1.monthly_rent).to eq(1200)
    expect(@unit1.bathrooms).to eq(1)
    expect(@unit1.bedrooms).to eq(1)
  end

  it "adds renters" do
    expect(@unit1.renter).to eq(nil)
    @unit1.add_renter(@renter1)
    expect(@unit1.renter).to eq(@renter1)
  end

  it "returns rental status" do
    expect(@unit1.rented?).to eq(false)
    @unit1.add_renter(@renter1)
    expect(@unit1.rented?).to eq(true)
  end
end
