# frozen_string_literal: true

require "rails_helper"

RSpec.describe HomeController, type: :controller do

  describe "GET / (:index)" do
    it "renders the home page when user is not logged in" do
      get :index
      expect(response).to render_template("home/index")
    end
    it "redirects to My Dashboard when user is logged in" do
      user = create(:user)
      sign_in(user)
      get :index
      expect(response).to redirect_to(plans_path)
    end
    it "redirects to Profile page when user is logged in but has the default name" do
      user = create(:user, firstname: "First Name", surname: "Surname")
      sign_in(user)
      get :index
      expect(response).to redirect_to(edit_user_registration_path)
    end
    it "redirects to Registration page when Shib data is in session" do
      get :index, session: { "devise.shibboleth_data": "foo" }
      expect(response).to redirect_to(new_user_registration_path)
    end
  end

end
