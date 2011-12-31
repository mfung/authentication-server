class AccessRight < ActiveRecord::Base
  after_validation :initialize_fields, :on => :create
  belongs_to :user
  belongs_to :client
  
  private
  
  def initialize_fields
    self.default_user = false
  end
end
