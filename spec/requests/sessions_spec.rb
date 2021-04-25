require "rails_helper"

RSpec.describe "Sessions", type: :request do
  let!(:user) { create(:user) }
  describe "GET /sessions#create" do
    let(:valid_credentials) { { email: user.email, password: user.password } }
    context "when login valid" do
      before do
        post "/users/sign_in", params: valid_credentials
      end

      it "return status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when email is invalid" do
      let(:invalid_attributes) { { email: user.email + "1", password: user.password } }
      before do
        post "/users/sign_in", params: invalid_attributes
      end

      it "return couldn't find user" do
        expect(flash[:alert]).to match(/Invalid Email or password./)
      end
    end

    context "when email is not present" do
      let(:invalid_attributes) { { email: "", password: user.password } }
      before do
        post "/users/sign_in", params: invalid_attributes
      end

      it "return couldn't find user" do
        expect(flash[:alert]).to match(/Invalid Email or password./)
      end
    end

    context "when password is incorrect" do
      let(:valid_attributes) { { email: user.email, password: "" } }
      before do
        post "/users/sign_in", params: valid_attributes
      end

      it "return couldn't find user" do
        expect(flash[:alert]).to match(/Invalid Email or password./)
      end
    end
  end
end
