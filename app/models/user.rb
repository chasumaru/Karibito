class User < ApplicationRecord
  validates(:name, presence: true)
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable
        #  #omniauthableは後で設定
        #  :omniauthable, omniauth_providers: [:twitter]
end
