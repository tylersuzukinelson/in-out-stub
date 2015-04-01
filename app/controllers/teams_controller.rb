class TeamsController < ApplicationController

  before_filter :find_team, only: [:show, :edit, :update, :destroy]

  def index
    @teams = Team.all
  end

  def create
    @team = Team.new name: params['team']['name']
    @team.save
    respond_to do |format|
      format.js { render }
    end
  end

  def update
    @team.update_attributes name: params[:team][:name]
    respond_to do |format|
      format.js { render }
    end
  end

  def destroy
    @team.destroy
    respond_to do |format|
      format.js { render }
    end
  end

  private

  def find_team
    @team = Team.find params[:id]
  end

  def get_errors
    @team.errors.full_messages.join('; ')
  end

end