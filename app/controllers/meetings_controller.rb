class MeetingsController < ApplicationController
  before_action :authenticate_user!
  # before_action :authorize_user!, only: [:new, :create]

  def index
    @meetings = Meeting.order(id: :desc) 
    @user_timezone = current_user.timezone || "UTC"
    @meeting = Meeting.new
    @users = User.all
  end

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.time = Time.zone.parse(meeting_params[:time])
    @meeting.save
    if @meeting.save
      @meeting.users.each do |user|
        UserMailer.invite(user, @meeting).deliver_now
      end
      redirect_to meetings_path, notice: "Meeting was successfully created."
    else
      @meetings = Meeting.all
      @users = User.all
      render :index
    end
  end

  private

  def meeting_params
    params.require(:meeting).permit(:topic, :time, user_ids: [])
  end

  # def authorize_user!
  #   redirect_to root_path, alert: 'Not authorized' unless current_user.role.in?(['Admin', 'Manager'])
  # end

end




