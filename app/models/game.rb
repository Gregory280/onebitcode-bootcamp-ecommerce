class Game < ApplicationRecord
  belongs_to :system_requirement
  has_one :product, as: :productable
  validates :mode, presence: true
  enum mode: { pvp: 1, pve: 2, both: 3 }
  validates :release_date, presence: true
  validates :developer, presence: true
end
