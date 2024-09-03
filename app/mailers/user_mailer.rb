
class UserMailer < ApplicationMailer

  include ApplicationHelper

  default from: "vishalrathore1319992@gmail.com"


  def send_otp
    @user = params[:user]
    @otp_code = params[:otp_code]
    mail(to: @user.email, subject: 'Your OTP Code')
  end

  def task_assignment_notification(task, assigned_user)
    @task = task
    @assigned_user = assigned_user
    @project = task.project
    @assigned_by = User.find(task.assigned_by)  # assuming this is the user who assigned the task

    mail(
      to: @assigned_user.email,
      subject: "New Task Assigned: #{@task.title}"
    )
  end


  def invite(user, meeting)
    @user = user
    @meeting = meeting
    @meeting_time = formatted_time_for_user(@user, @meeting.time)
    mail(to: @user.email, subject: "You're invited to a meeting")
  end


end


