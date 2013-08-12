class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


	has_many :brews, :dependent=>:destroy
	has_many :steps, :dependent=>:destroy
	has_many :inventories, :dependent=>:destroy

end
