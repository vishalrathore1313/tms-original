

require 'securerandom'


class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Virtual attribute to store OTP temporarily
  attr_accessor :otp_code

  # Method to generate OTP and send it via email
  def generate_otp_code
    self.otp_code = SecureRandom.random_number(10**6).to_s.rjust(6, '0') 
    save!
    UserMailer.with(user: self, otp_code: otp_code).send_otp.deliver_now
  end

  # Method to verify OTP
  def verify_otp(submitted_otp)

    puts "store #{otp_code}"
    puts "submitted #{submitted_otp}"

    otp_code == submitted_otp
  end
end





