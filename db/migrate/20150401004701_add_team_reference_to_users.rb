class AddTeamReferenceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :team_id, :integer, index: true, references: :teams
  end
end
