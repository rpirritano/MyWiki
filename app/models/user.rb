class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable#, :confirmable, :lockable #, :zxcvbnable

has_many :wikis
has_many :collaborators
#before_save { self.role ||= :standard }
after_initialize {self.role ||= :standard}

enum role: [:standard, :admin, :premium]

scope :public_wikis, -> { where('(wikis.private IS NULL OR wikis.private = ?)', false) }
scope :private_wikis, -> { where('(wikis.private = ? AND wikis.user_id = ?)', true, @user.id) }

 def send_devise_notification(notification, *args)
   devise_mailer.send(notification, self, *args).deliver_later
 end
end
