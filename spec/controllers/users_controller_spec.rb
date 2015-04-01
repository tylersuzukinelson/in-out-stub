require 'spec_helper'

describe UsersController do

  let(:user) { create(:user) }
  let(:user2) { create(:user) }

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

  describe "GET show" do

    context "with user logged in" do

      before {
        sign_in user
        get :show, id: user.id
      }

      it "assigns the user instance" do
        expect(assigns(:user)).to eq(user)
      end

      it "renders the show template" do
        expect(response).to render_template(:show)
      end

    end

    context "without user logged in" do

      before {
        get :show, id: user.id
      }

      it "redirects to the login page" do
        expect(response).to redirect_to(new_user_session_path)
      end

    end

  end

  describe "GET edit" do

    context "with user logged in" do

      before {
        sign_in user
      }

      context "edit own user" do

        before {
          get :edit, id: user.id
        }

        it "assigns the user instance" do
          expect(assigns(:user)).to eq(user)
        end

        it "renders the edit template" do
          expect(response).to render_template(:edit)
        end

      end

      context "edit another user" do

        before {
          get :edit, id: user2.id
        }

        it "sets a flash alert" do
          expect(flash[:alert]).to eq("You can't edit other users' information.")
        end

        it "redirects to the users index" do
          expect(response).to redirect_to(users_path)
        end

      end

    end

    context "without user logged in" do

      before {
        get :edit, id: user.id
      }

      it "redirects to the login page" do
        expect(response).to redirect_to(new_user_session_path)
      end

    end

  end

  describe "PUT update" do

    context "HTML format" do

      context "with user logged in" do

        before {
          sign_in user
        }

        context "update own user" do

          before {
            put :update, {
              id: user.id,
              user: {
                first_name: "Bob"
              }
            }
          }

          it "assigns the user instance" do
            expect(assigns(:user)).to eq(user)
          end

          it "updates the user" do
            expect(user.reload.first_name).to eq("Bob")
          end

          it "redirects to the users index" do
            expect(response).to redirect_to(users_path)
          end

        end

        context "update another user" do

          before {
            put :update, {
              id: user2.id,
              user: {
                first_name: "Bob"
              }
            }
          }

          it "doesn't update the user" do
            expect(user.reload.first_name).not_to eq("Bob")
          end

          it "sets a flash alert" do
            expect(flash[:alert]).to eq("You can't edit other users' information.")
          end

          it "redirects to the users index" do
            expect(response).to redirect_to(users_path)
          end

        end

      end

      context "without user logged in" do

        before {
          put :update, id: user.id
        }

        it "redirects to the login page" do
          expect(response).to redirect_to(new_user_session_path)
        end

      end

    end

    context "JS format" do

      context "with user logged in" do

        before {
          sign_in user
          xhr :put, :update, {
            id: user.id,
            user: {
              status: :in
            }
          }
        }

        it "assigns the user instance" do
          expect(assigns(:user)).to eq(user)
        end

        it "updates the user" do
          expect(user.reload.status).to eq(:in)
        end

        it "render the update template" do
          expect(response).to render_template(:update)
        end

      end

      context "without user logged in" do

        before {
          xhr :put, :update, {
            id: user.id,
            user: {
              status: :in
            }
          }
        }

        it "gives an authorization error" do
          expect(response.code).to eq('401')
        end

      end

    end

  end

end
