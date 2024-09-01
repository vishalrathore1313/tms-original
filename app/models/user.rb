class User < ApplicationRecord
  # Include default devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 has_many :meeting_participants, dependent: :destroy
 has_many :meetings, through: :meeting_participants

  # Validations
  validates :otp_code, presence: true, on: :otp_verification, if: :verification_pending?
  validates :timezone, presence: true

  # Method to generate OTP and save it to the database
  def generate_otp_code
    self.otp_code = SecureRandom.random_number(10**6).to_s.rjust(6, '0') # Generate a 6-digit OTP
    self.verification = false # Ensure verification is false until OTP is validated
    save!
    UserMailer.with(user: self, otp_code: otp_code).send_otp.deliver_now
  end

  # Method to verify OTP and update verification status
  def verify_otp(submitted_otp)
    if otp_code == submitted_otp

      update(verification: true, otp_code: nil) # Clear the OTP after successful verification

      true
    else
      false
    end
  end



  ROLES = %w[admin manager team_member]

  # Validations
  validates :role, presence: true, inclusion: { in: ROLES }

  # Method to check if the user is an admin
  def admin?
    role == 'admin'
  end

  # Method to check if the user is a manager
  def manager?
    role == 'manager'
  end

  # Method to check if the user is a team member
  def team_member?
    role == 'team_member'
  end

  scope :team_members, -> { where(role: 'team_member') }

  # Alternatively, if you have a method to check if a user is a team member:
  def self.team_members
    where(role: 'team_member')
  end


    # enum role: { admin: 0, manager: 1, team_member: 2 }
  
  

  private

  def verification_pending?
    !self.verification
  end
  
end

