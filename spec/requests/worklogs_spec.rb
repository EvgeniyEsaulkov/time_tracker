# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Worklogs" do
  describe "GET /worklogs" do
    context "when a user is authenticated" do
      let(:user) { create(:user) }

      before do
        sign_in user
        get "/worklogs"
      end

      it "returns a successful response" do
        expect(response).to have_http_status(:ok)
      end

      it "renders the index template" do
        expect(response).to render_template(:index)
      end
    end

    context "when a user is not authenticated" do
      it "redirects to the login page" do
        get "/worklogs"
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
