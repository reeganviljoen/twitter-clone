class User < ApplicationRecord
  has_many :tweets 
  has_many :likes

  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  before_create :set_name

  private
  def set_name
    split_email = email.split('@')
    self.name = split_email[0]
  end
end
