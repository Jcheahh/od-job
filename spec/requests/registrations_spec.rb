require "rails_helper"

RSpec.describe "Registrations", type: :request do
  let!(:user) { build(:user) }
  describe "GET /registrations#create" do
    let(:valid_credentials) { { email: user.email, password: user.password, username: user.username } }
    context "when registrations valid" do
      before do
        post "/users", params: valid_credentials
      end

      it "return status code 200" do
        expect(response).to have_http_status(200)
      end

      it "return created user" do
        expect(response.body).not_to be_empty
      end
    end

    context "when email is empty" do
      let(:invalid_attributes) { { password: user.password } }
      before do
        post "/users", params: invalid_attributes
      end
      it "return email can't be blank" do
        expect(response.body).to match(/Email can&#39;t be blank/)
      end
    end

    context "when password is empty" do
      let(:invalid_attributes) { { email: user.email } }
      before do
        post "/users", params: invalid_attributes
      end
      it "return password can't be blank" do
        expect(response.body).to match(/Password can&#39;t be blank/)
      end
    end
  end
end
