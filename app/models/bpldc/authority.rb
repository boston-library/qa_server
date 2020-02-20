class Bpldc::Authority < ApplicationRecord
  validates :label, presence: true

  scope :subjects, -> { where(subject: true) }
  scope :names, -> { where(name: true) }
  scope :genres, -> { where(genre: true) }
  scope :geographics, -> { where(geographic: true) }
end
