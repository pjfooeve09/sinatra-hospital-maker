class Hospital < ActiveRecord::Base
  belongs_to :user
  has_many :patients
end