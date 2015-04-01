require 'spec_helper'

describe UsersController do

  let(:user) { create(:user) }

  describe "GET index" do

    context "with user logged in" do

      before {
        sign_in user
        get :index
      }

      it "assigns a teams instance variable" do
        expect(assigns(:teams)).to be
      end

      it "renders the index template" do
        expect(response).to render_template("index")
      end

    end

    context "without user logged in" do

      before {
        get :index
      }

      it "redirects to the login page" do
        expect(response).to redirect_to(new_user_session_path)
      end

    end

  end

end
