require 'rails_helper'

RSpec.describe Meal, type: :model do
  subject {
    described_class.new(name: "Caprese Salad", photo: "defaultPhoto.png", rating: 4)
  }

  it "should be valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "should require a valid name" do
    subject.name = ""
    expect(subject).to_not be_valid
  end

  it "should require a name with at least two characters" do
    subject.name = "C"
    expect(subject).to_not be_valid
  end

  it "should require a name with no more than 50 characters" do
    subject.name = "Lorem ipsum dolor sit amet, consectetur adipiscing volutpat"
    expect(subject).to_not be_valid
  end

  it "should require a numerical value for rating" do
    subject.rating = "H"
    expect(subject).to_not be_valid
  end

  it "should require a rating value greater than or equal to 0" do
    subject.rating = -1
    expect(subject).to_not be_valid
  end

  it "should require a rating value less than or equal to 5" do
    subject.rating = 6
    expect(subject).to_not be_valid
  end
end
