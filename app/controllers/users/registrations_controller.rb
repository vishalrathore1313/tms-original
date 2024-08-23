# class Users::RegistrationsController < ApplicationController


# end

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_existing_user, only: [:create]

  # Override the create action to handle OTP generation
  def create
    build_resource(sign_up_params)
    if resource.save
      resource.generate_otp_code
      @user= resource   #make change here
      # render 'otp_verification'
      # render 'verify_otp_path'
    else
      render :new
    end
  end

  # Custom action for OTP verification
  def verify_otp
    user = User.find_by(email: params[:email])
    if user&.verify_otp(params[:otp_code])
      sign_in(user)
      redirect_to root_path, notice: 'Your account has been verified.'
    else
      flash.now[:alert] = 'Invalid OTP code.'
      render :otp_verification
    end
  end

  # Custom action for resending OTP
  def resend_otp
    user = User.find_by(email: params[:email])
    if user
      user.generate_otp_code
      flash[:notice] = 'A new OTP code has been sent to your email.'
    else
      flash[:alert] = 'Email not found.'
    end
    redirect_to new_user_registration_path
  end

  private

  # Check if the user with the given email already exists
  def check_existing_user
    if User.exists?(email: sign_up_params[:email])
      flash[:alert] = 'Email already exists. Please verify your email.'
      redirect_to new_user_registration_path
    end
  end
end

