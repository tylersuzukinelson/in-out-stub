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

      it "gives an authorization error" do
        expect(response.code).to eq('401')
      end

    end

  end

  describe "PATCH update" do

  end

  describe "DELETE destroy" do

  end

end
