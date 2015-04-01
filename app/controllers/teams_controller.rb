class TeamsController < ApplicationController

  before_filter :find_team, only: [:show, :edit, :update, :destroy]

  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new params[:team][:name]
    if @team.save
      redirect_to @team
    else
      flash[:alert] = get_errors
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @team.update name: params[:team][:name]
      redirect_to @team
    else
      redirect_to @team, alert: get_errors
    end
  end

  def destroy
    if @team.destroy
      flash[:notice] = "Team deleted."
      @team = Team.new
      render :new
    else
      redirect_to @team, alert: get_errors
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
