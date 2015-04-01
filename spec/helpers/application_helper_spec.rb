require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do

  let(:user) { create(:user) }

  describe "#name_with_status" do

    it "contains a link to the user" do
      expect(helper.name_with_status(user.full_name, user.status, user.id)).to include("<a href=\"#{user_path(user)}\"")
    end

    it "contains a span listing the status" do
      expect(helper.name_with_status(user.full_name, user.status, user.id)).to include("<span class=\"status status-in\">in</span>")
    end

    it "contains a link to update the user's status" do
      expect(helper.name_with_status(user.full_name, user.status, user.id)).to include("<a href=\"#{status_user_path(user)}\"")
    end

  end

end