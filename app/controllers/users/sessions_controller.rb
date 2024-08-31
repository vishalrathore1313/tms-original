class Users::SessionsController < Devise::SessionsController


  def create
    user = User.find_by(email: params[:user][:email])

    if user && !user.verification
      flash[:alert] = 'Your account is not verified. Please check your email for the OTP verification link.'
      redirect_to new_user_session_path
    else
      super
    end
  end



end