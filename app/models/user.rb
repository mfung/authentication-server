class User < ActiveRecord::Base
  tango_user
  simple_roles
  has_many :access_grants, :dependent => :delete_all
  
  has_many :access_rights
  has_many :clients, :through => :access_rights 
  
  before_validation :initialize_fields, :on => :create
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  self.token_authentication_key = "access_token"

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :department
  
  validates_uniqueness_of :email, :allow_blank => true
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true
  
  def self.find_for_token_authentication(conditions)
    where(["access_grants.access_token = ? AND (access_grants.access_token_expires_at IS NULL OR access_grants.access_token_expires_at > ?)", conditions[token_authentication_key], Time.now]).joins(:access_grants).select("users.*").first
  end
  
  def fullname
    "#{self.first_name} #{self.last_name}"
  end
  
  def initialize_fields
    self.status = "Active"
    self.expiration_date = 1.year.from_now
  end
  
  def serialize_data
    "Email:" + self.email.to_s + "|Name:" + self.first_name.to_s + self.last_name + "|Status:" + self.status.to_s + "|Department:" + self.department.to_s
  end
  
end

