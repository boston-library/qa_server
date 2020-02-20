# frozen_string_literal: true

class Bpldc::Authority < ApplicationRecord
  validates :code, presence: true, uniqueness: true

  scope :subjects, -> { where(subjects: true) }
  scope :names, -> { where(names: true) }
  scope :genres, -> { where(genres: true) }
  scope :geographics, -> { where(geographics: true) }
end
