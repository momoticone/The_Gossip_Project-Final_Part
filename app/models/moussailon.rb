class Moussailon < ApplicationRecord
    has_many :gossip
    
    
    attr_accessor :login
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    validates :username, presence: true, uniqueness: {case_sensitive: false}, format: { with: /\A[a-zA-Z0-9]+\Z/ }
    
    
    
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable , :confirmable
    
    def self.find_first_by_auth_conditions(warden_conditions)
    
        conditions = warden_conditions.dup
        if login = conditions.delete(:login)
            where(conditions.to_hash).where("lower(username) = :value OR lower(email) = :value", value: login.downcase).first
        else
            where(conditions.to_hash).first
        end
    end
    
end