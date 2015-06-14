class Url < ActiveRecord::Base

  belongs_to :media_collection

  validates :url, url: { message: 'не верна' }

end
