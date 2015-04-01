class UsersController < ApplicationController
  before_filter :only_myself, only: :edit
  before_filter(only: :update) do |controller|
    controller.send(:only_myself) unless controller.request.format.js?
  end

  def index
    @users = User.without_user(current_user)
  end

  def status
    @user = User.find(params[:id])
    respond_to do |format|
      format.json { render :json =>  @user.to_json(:only => [:id, :status], :methods => [:full_name]) }
    end
  end

  def status_all
    @users = User.without_user(current_user)
    respond_to do |format|
      format.js { render }
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    params[:user][:team_id] = nil if params[:user][:team_id] == '0'
    @user.update_attributes(params[:user])
    respond_to do |format|
      format.html { redirect_to users_path }
      format.js { render }
    end
  end

  private

  def only_myself
    unless current_user.id == params[:id].to_i
      flash[:alert] = "You can't edit other users' information."
      redirect_to users_path
    end
  end

end
