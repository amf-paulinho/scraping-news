class HeadLine < ApplicationRecord
	  validates :source, presence: true
      validates :content_id, presence: true
      validates :title, presence: true
      validates :link, presence: true
	  validates :scrape_date, presence: true
end
