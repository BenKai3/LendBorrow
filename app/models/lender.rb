class Lender < ActiveRecord::Base
  has_many :borrowers, through: :historys
  attr_accessor :password, :password_confirmation

  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

  validates :first_name, :last_name,				:presence 		=> true,
  			                                        :length		    => { :maximum => 50 }
  			    										
  validates :email,		  							:presence		=> true,
  			    									:format		    => { :with => email_regex },
            										:uniqueness 	=> { :case_sensitive => false }

  validates :password, 								:presence 		=> true,
  	   		  										:confirmation 	=> true,
  			    									:length			=> { :within => 6..40 }

  before_save :encrypt_password

  def has_password?(submitted_password)
  	encrypted_password == encrypt(submitted_password)
  end

  # class method that checks whether the lender's email and submitted_password are valid
  def self.authenticate(email, submitted_password)
  	lender = find_by_email(email)

   	return nil if lender.nil?
   	return lender if lender.has_password?(submitted_password)
  end


  private
  	def encrypt_password
  		# generate a unique salt if it's a new lender
  		self.salt = Digest::SHA2.hexdigest("#{Time.now.utc}--#{password}") if self.new_record?
  	
  		# encrypt the password and store that in the encrypted_password field
  		self.encrypted_password = encrypt(password)
  	end

  	# encrypt the password using both the salt and the passed password
  	def encrypt(pass)
  		Digest::SHA2.hexdigest("#{self.salt}--#{pass}")
  	end

end
