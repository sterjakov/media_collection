class MediaCollection < ActiveRecord::Base

  belongs_to :user
  has_many :images, dependent: :destroy
  has_many :urls, dependent: :destroy

  accepts_nested_attributes_for :images, :reject_if => :all_blank, allow_destroy: true
  accepts_nested_attributes_for :urls, :reject_if => :all_blank, allow_destroy: true

  # Доступность коллекции
  AVAILABLE = [
      [ 'Только мне', 0 ],
      [ 'Всем', 1 ]
  ]

  validates :user_id, :name, :available, presence: true
  validates :available, inclusion: { in: AVAILABLE.map{ |k,v| v } }

end
