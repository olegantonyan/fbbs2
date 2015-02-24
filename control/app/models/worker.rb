class Worker < ActiveRecord::Base
  has_and_belongs_to_many :target_platforms
  
  validates :title, length: {in: 1..100}
  validates :address, length: {in: 2..100}
end
