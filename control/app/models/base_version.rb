class BaseVersion < ActiveRecord::Base
  has_and_belongs_to_many :enviroments
  has_many :build_jobs
  
  validates :name, length: { in: 1..100 }, uniqueness: true
  
  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end
  
end
