require "rails_helper"

RSpec.describe "Claims", type: :request do
  let!(:user) { create(:user) }
  let!(:job) { create(:job, user_id: user.id) }
  let!(:claim) { create(:claim, job_id: job.id, user_id: user.id) }
  describe "GET /claims#index" do
    before do
      sign_in user
      get "/claims"
    end
    it "return status code 200" do
      expect(response).to have_http_status(200)
    end

    it "return claims" do
      expect(response.body).not_to be_empty
    end
  end

  describe "POST /claims#create" do
    let(:valid_attributes) { { job_id: job.id } }
    context "when the job is not claim" do
      before do
        sign_in user
        post "/claims", params: valid_attributes
      end
      it "return status code 302" do
        expect(response).to have_http_status(302)
      end

      it "return created claim" do
        expect(response.body).not_to be_empty
      end
    end

    context "when the job is claimed" do
      it "return validate fail" do
        sign_in user
        post "/claims", params: { job_id: job.id }
        expect(flash[:danger]).to be_present
      end
    end

    context "when the job created by yourself" do
      let(:anotheruser) { create(:user) }
      let(:anotherjob) { create(:job, user_id: anotheruser.id) }
      it "return you cant claim your own job" do
        sign_in anotheruser
        post "/claims", params: { job_id: anotherjob.id }
        expect(flash[:danger]).to be_present
      end
    end
  end
end
