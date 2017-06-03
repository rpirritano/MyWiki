class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable#, :confirmable, :lockable #, :zxcvbnable

has_many :wikis
#before_save { self.role ||= :standard }
after_initialize {self.role ||= :standard}

enum role: [:standard, :admin, :premium]

 def send_devise_notification(notification, *args)
   devise_mailer.send(notification, self, *args).deliver_later
 end
end
