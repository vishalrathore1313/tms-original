
  class MeetingsController < ApplicationController

    before_action :authenticate_user!
    before_action :authorize_user!, only: [:new, :create]

    def index
        @meetings = Meeting.all
        @users = User.all # This line ensures @users is available for the form
    end

    def new
        @meeting = Meeting.new
        @users = User.all # This line ensures @users is available for the form
      end
  
    def create
      @meeting = Meeting.new(meeting_params)
      if @meeting.save
        @meeting.users.each do |user|
            UserMailer.invite(user, @meeting).deliver_now
        end
        redirect_to meetings_path, notice: "Meeting was successfully created."
      else
        @users = User.all
        render :new
      end
    end
  
    private
  
    def meeting_params
      params.require(:meeting).permit(:topic, :time, user_ids: [])
    end


    def authorize_user!
        redirect_to root_path, alert: 'Not authorized' unless current_user.role.in?(['Admin', 'Manager'])
      end
  end
  

