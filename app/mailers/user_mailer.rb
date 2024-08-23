
class UserMailer < ApplicationMailer

  default from: "vishalrathore1319992@gmail.com"

  def send_otp
    @user = params[:user]
    @otp_code = params[:otp_code]
    mail(to: @user.email, subject: 'Your OTP Code')
  end
end


