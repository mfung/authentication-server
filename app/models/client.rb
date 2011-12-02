class Client < ActiveRecord::Base
  has_many :access_rights
  has_many :users, :through => :access_rights
  
  before_create :generate_fields
  before_validation :filter_remote_roles_path, :only => [:create, :update]
  validates_presence_of :name, :on => :create
  
  def self.authenticate(app_id, app_secret)
    where(["app_id = ? AND app_secret = ?", app_id, app_secret]).first
  end
  
  def generate_fields
    self.app_id, self.app_secret = SecureRandom.hex(16), SecureRandom.hex(16)
  end
  
  private
  def filter_remote_roles_path
    self.remote_roles_path = ("/" + self.remote_roles_path) if self.remote_roles_path[0] != '/' 
  end
end
