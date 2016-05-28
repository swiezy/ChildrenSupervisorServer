class Parent < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :children, dependent: :destroy
  ratyrate_rater

  validates :parent_name, presence: true
end
