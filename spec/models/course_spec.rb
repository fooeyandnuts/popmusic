require 'spec_helper'

describe Course do
  it "is valid with a name" do
  	race = Course.new(name: "marathon")
  	expect(race).to be_valid
  end

  it "is not valid without a name" do
  	race = Course.new(name: nil)
  	expect(race).to be_invalid  	
  end  

  describe "#name" do
  	it "returns a string in the format of 'Your race is called the NAME'" do
  		race = Course.new(name: "Santa Monica 5000")
  		expect(race.name).to eq "Your race is called the Santa Monica 5000"
  	end
  end
end
