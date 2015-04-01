require 'rails_helper'

RSpec.describe Team, :type => :model do

  describe "name validations" do

    context "valid request" do

      it "creates a new team" do
        team = Team.create name: "Salespeople"
        expect(Team.last).to eq(team)
      end

    end

    context "invalid request" do

      context "name does not exist" do

        it "does not create a new team" do
          team = Team.create name: ""
          expect(team.errors[:name]).to include("can't be blank")
        end

      end

      context "name is not unique" do

        it "does not create a new team" do
          team1 = Team.create name: "Salespeople"
          team2 = Team.create name: "Salespeople"
          expect(team2.errors[:name]).to include("has already been taken")
        end

      end

    end

  end

end
