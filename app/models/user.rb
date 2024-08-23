

require 'securerandom'

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  attr_accessor :otp_code

  before_create :set_default_verification

  def generate_otp_code
    self.otp_code = SecureRandom.hex(3) # Generates a 6-character OTP
    save(validate: false)
    UserMailer.with(user: self, otp_code: otp_code).send_otp.deliver_now
  end

  def verify_otp(code)
    return false unless otp_code == code
    update(verification: true, otp_code: nil)
    true
  end

  private

  def set_default_verification
    self.verification ||= false
  end
end






