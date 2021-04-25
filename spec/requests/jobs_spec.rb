require "rails_helper"

RSpec.describe "Jobs" do
  let!(:user) { create(:user) }
  let!(:job) { create(:job, user_id: user.id) }
  let(:job_id) { job.id }
  describe "GET /jobs#index" do
    before do
      sign_in user
      get "/jobs"
    end
    it "return status code 200" do
      expect(response).to have_http_status(200)
    end

    it "return jobs" do
      expect(response.body).not_to be_empty
    end
  end

  describe "GET /jobs#show" do
    before do
      sign_in user
      get "/jobs/#{job_id}"
    end
    context "when the job exists" do
      it "return status code 200" do
        expect(response).to have_http_status(200)
      end

      it "return the job" do
        expect(response.body).not_to be_empty
      end
    end

    context "when the job doesn't exists" do
      let(:job_id) { 0 }
      it "return cannot find" do
        expect(response.body).to match(/Couldn't find Job/)
      end
    end
  end

  describe "POST /jobs" do
    before do
      sign_in user
      post "/jobs",
           params: { title: "example", description: "example", pick_up_address: "example", pick_up_latitude: 1,
                     pick_up_longitude: 1, drop_off_address: "example1", drop_off_latitude: 2, drop_off_longitude: 2 }
    end
    context "when the job is valid" do
      it "return created job" do
        expect(response.body.title).to eq("example")
      end
    end
  end
end
