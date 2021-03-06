require 'rails_helper'

RSpec.describe TeamsController, :type => :controller do

  let(:user) { create(:user) }
  let(:team) { create(:team) }

  describe "POST create" do

    context "with user logged in" do

      before {
        sign_in user
        xhr :post, :create, {
          team: {
            name: "Salespeople"
          }
        }
      }

      it "assigns the team instance" do
        expect(assigns(:team)).to eq(Team.last)
      end

      it "creates a new team in the database" do
        expect(Team.last.name).to eq("Salespeople")
      end

      it "renders the create template" do
        expect(response).to render_template(:create)
      end

    end

    context "without user logged in" do

      before {
        xhr :post, :create, {
          team: {
            name: "Salespeople"
          }
        }
      }

      it "doesn't create a new team in the database" do
        expect(Team.last).not_to be
      end

      it "gives an authorization error" do
        expect(response.code).to eq('401')
      end

    end

  end

  describe "PUT update" do

    context "with user logged in" do

      before {
        sign_in user
        xhr :put, :update, {
          id: team.id,
          team: {
            name: "Salespeople"
          }
        }
      }

      it "assigns the team instance" do
        expect(assigns(:team)).to eq(team)
      end

      it "updates the team" do
        expect(team.reload.name).to eq("Salespeople")
      end

      it "renders the update template" do
        expect(response).to render_template(:update)
      end

    end

    context "without user logged in" do

      before {
        xhr :put, :update, {
          id: team.id,
          team: {
            name: "Salespeople"
          }
        }
      }

      it "doesn't update the team" do
        expect(team.reload.name).not_to eq("Salespeople")
      end

      it "gives an authorization error" do
        expect(response.code).to eq('401')
      end

    end

  end

  describe "DELETE destroy" do

    def destroy_request
      xhr :delete, :destroy, id: team.id
    end

    context "with user logged in" do

      before {
        sign_in user
      }

      it "assigns the team instance" do
        destroy_request
        expect(assigns(:team)).to eq(team)
      end

      it "deletes the team" do
        team
        expect{ destroy_request }.to change{Team.count}.by(-1)
      end

      it "renders the destroy template" do
        destroy_request
        expect(response).to render_template(:destroy)
      end

    end

    context "without user logged in" do

      it "doesn't delete the team" do
        destroy_request
        expect(Team.last).to eq(team)
      end

      it "gives an authorization error" do
        destroy_request
        expect(response.code).to eq('401')
      end

    end

  end

end
