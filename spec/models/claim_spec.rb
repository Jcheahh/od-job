require "rails_helper"

RSpec.describe Claim, type: :model do
  let!(:user) { create(:user) }
  let!(:job) { create(:job, user_id: user.id) }
  subject { described_class.new(status: 1, user_id: user.id, job_id: job.id) }
  it "is valid when Claim Model is valid" do
    expect(subject).to be_valid
  end
end
