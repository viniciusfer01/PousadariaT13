class List < ApplicationRecord
  belongs_to :inn_owner
  has_and_belongs_to_many :inns

  validates :name, presence: true
end
