class UsersController < ApplicationController
  def index
    @users = User.where(artist: true)
  end

  def show
    @user = User.find(params[:id])
    artists = RSpotify::Artist.search(@user.artist_name)
    @artist = artists.first
  end

  def account
    @events = Event.where(user: current_user)
    @event = Event.new
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to users_account_path
  end

  def ticket
    @events = Event.where(user: current_user)
  end

  private

  # PARAMS
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :location, :dob, :rich_body)
  end
end
