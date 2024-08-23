# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_existing_user, only: [:create]

  # Override the create action to handle OTP generation
  def create
    build_resource(sign_up_params)

    if resource.save
      resource.generate_otp_code
      session[:otp_email] = resource.email
      redirect_to otp_verification_path
    else
      render :new
    end
  end

  # Custom action for OTP verification
  def verify_otp
    @user = User.find_by(email: session[:otp_email])
    # @user.update(verification: true)
    if @user&.verify_otp(params[:otp_code])
      @user.update(verification: true)
      sign_in(@user)
      session.delete(:otp_email) # Clear session data
      redirect_to root_path, notice: 'Your account has been verified.'
    else
      flash.now[:alert] = 'Invalid OTP code.'
      render :otp_verification
    end
  end

  # Custom action for resending OTP
  def resend_otp
    @user = User.find_by(email: params[:email])
    if @user
      @user.generate_otp_code
      flash[:notice] = 'A new OTP code has been sent to your email.'
    else
      flash[:alert] = 'Email not found.'
    end
    redirect_to new_user_registration_path
  end

  private

  # Check if the user with the given email already exists
  def check_existing_user
    @user = User.find_by(email: sign_up_params[:email])
    if @user
      if @user.verified?
        flash[:alert] = 'Email already exists. Please sign in.'
        redirect_to new_user_session_path
      else
        flash[:alert] = 'Email already exists but is not verified. Please verify your account.'
        redirect_to new_user_registration_path
      end
    end
  end
end

