class MeetingsController < ApplicationController
  before_action :authenticate_user!
  # before_action :authorize_user!, only: [:new, :create]

  def index
    @meetings = Meeting.order(id: :desc)
    @users = User.all
    @user_timezone = current_user.timezone || "UTC"
    @meeting = Meeting.new
  end
  
  def create
    @meeting = Meeting.new(meeting_params)
  
    # Check if time is present
    time_param = meeting_params[:time]
    
    if time_param.present?
      begin
        @meeting.time = Time.use_zone(current_user.timezone) { Time.zone.parse(time_param) }
      rescue ArgumentError
        @meeting.errors.add(:time, "is invalid")
        render :index and return
      end
    else
      @meeting.errors.add(:time, "can't be blank")
      render :index and return
    end
  
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




