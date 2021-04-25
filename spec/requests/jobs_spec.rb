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
      it "return status code 404" do
        expect(response).to have_http_status(404)
      end

      it "return cannot find" do
        expect(response.body).to match(/The page you were looking for doesn't exist/)
      end
    end
  end

  describe "POST /jobs#create" do
    let(:valid_attributes) do
      { job: { title: "example", description: "example", pick_up_address: "example", pick_up_latitude: 1,
               pick_up_longitude: 1, drop_off_address: "example1", drop_off_latitude: 2, drop_off_longitude: 2 } }
    end
    context "when the job is valid" do
      before do
        sign_in user
        post "/jobs",
             params: valid_attributes
      end
      it "return created job" do
        expect(response.body).not_to be_empty
      end
    end
    context "when the job is invalid" do
      before do
        sign_in user
        post "/jobs",
             params: { job: { title: "example" } }
      end
      it "return validate fail" do
        expect(flash[:danger]).to be_present
      end

      it "return status code 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "GET /jobs#mine" do
    before do
      sign_in user
      get "/jobs/mine"
    end
    context "when the user claimed a job" do
      it "return the user's job" do
        expect(response.body).not_to be_empty
      end

      it "return status code 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DESTROY /jobs#destroy" do
    context "when the job is not claimed" do
      before do
        sign_in user
        delete "/jobs/#{job_id}"
      end
      it " return status code 302" do
        expect(response).to have_http_status(302)
      end
    end

    context "when the job is claimed" do
      it "return status code 405" do
        job.create_claim(user_id: user.id)
        sign_in user
        delete "/jobs/#{job_id}"
        expect(response).to have_http_status(405)
      end
      it "return validate fail" do
        job.create_claim(user_id: user.id)
        sign_in user
        delete "/jobs/#{job_id}"
        expect(flash[:danger]).to be_present
      end
    end

    context "when the job is not create by yourself" do
      let(:anotheruser) { create(:user) }
      it "return status code 404" do
        job.create_claim(user_id: user.id)
        sign_in anotheruser
        delete "/jobs/#{job_id}"
        expect(response).to have_http_status(404)
      end
    end
  end
end
