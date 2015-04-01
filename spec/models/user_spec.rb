require 'spec_helper'

describe User do

  let(:user) { create(:user) }

  describe "#status=" do
    before do
      user.status = status
    end

    context "when given an accepted value" do
      let(:status) { :in }
      it "writes the enumerated value in the database" do
        expect(user.send(:read_attribute, :status)).to eql User::STATUSES[status]
      end
    end

    context "when given an unacceptable value" do
      let(:status) { :bad_status }
      it "writes nil in the database" do
        expect(user.send(:read_attribute, :status)).to be_nil
      end
    end

  end

  describe "full name" do

    it "returns the appropriate full name" do
      user = User.create(first_name: "Bob", last_name: "Smith")
      expect(user.full_name).to eq("Bob Smith")
    end

  end

end
