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

  describe "GET status" do

    context "with user logged in" do

      before {
        sign_in user
        xhr :get, :status, id: user.id, format: :json
      }

      it "assigns the user instance variable" do
        expect(assigns(:user)).to eq(user)
      end

      it "renders a json object" do
        expected_json_object = {
          id: user.id,
          status: user.status,
          full_name: user.full_name
        }.to_json
        expect(response.body).to eq(expected_json_object)
      end

    end

    context "without user logged in" do

      before {
        xhr :get, :status, id: user.id
      }

      it "gives an authorization error" do
        expect(response.code).to eq('401')
      end

    end

  end

  describe "GET status_all" do

    context "with user logged in" do

      before {
        sign_in user
        xhr :get, :status_all
      }

      it "assigns the users instance" do
        expect(assigns(:users)).to eq(User.without_user(user))
      end

      it "renders the status_all template" do
        expect(response).to render_template(:status_all)
      end

    end

    context "without user logged in" do

      before {
        xhr :get, :status_all
      }

      it "gives an authorization error" do
        expect(response.code).to eq('401')
      end
      
    end

  end

end
