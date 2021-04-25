require "rails_helper"

RSpec.describe Job, type: :model do
  let(:user) { create(:user) }
  subject do
    described_class.new(title: "Pick parcel", description: "Help me to pick a parcel", pick_up_address: "example",
                        pick_up_latitude: 12, pick_up_longitude: 12, drop_off_address: "example", drop_off_latitude: 13, drop_off_longitude: 13, user_id: user.id)
  end
  it "is valid when Job Model is valid" do
    expect(subject).to be_valid
  end

  it "it not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "it not valid without pick up address" do
    subject.pick_up_address = nil
    expect(subject).to_not be_valid
  end

  it "it not valid without pick up latitude" do
    subject.pick_up_latitude = nil
    expect(subject).to_not be_valid
  end

  it "it not valid without pick up longitude" do
    subject.pick_up_longitude = nil
    expect(subject).to_not be_valid
  end

  it "it not valid without drop off address" do
    subject.drop_off_address = nil
    expect(subject).to_not be_valid
  end

  it "it not valid without drop off latitude" do
    subject.drop_off_latitude = nil
    expect(subject).to_not be_valid
  end

  it "it not valid without drop off longitude" do
    subject.drop_off_longitude = nil
    expect(subject).to_not be_valid
  end
end
