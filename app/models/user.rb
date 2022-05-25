class User < ApplicationRecord  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  validates :name, uniqueness: { case_sensitive: false }, presence: true, allow_blank: false, format: { with: /\A[a-zA-Z0-9]+\z/ }  
  
  has_many :groups,  class_name: "Group", foreign_key: "author_id", dependent: :delete_all
  has_many :entities,  class_name: "Entity", foreign_key: "author_id", dependent: :delete_all

  def admin?
    role == 'admin'
  end  
end
