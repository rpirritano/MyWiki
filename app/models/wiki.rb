class Wiki < ApplicationRecord
  
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  default_scope { order('title') }
  scope :visible_to, -> (user) { user ? all : where(private: false) }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user, presence: true

  def collaborator_for(user)
    collaborators.where(user_id: user.id).first
  end


end


