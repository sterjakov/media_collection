class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :media_collections

  before_create :set_default_role

  private

  # Назначанем роль по умолчанию
  # Вего две роли author и admin
  def set_default_role
    self.role = 'author'
  end

end
