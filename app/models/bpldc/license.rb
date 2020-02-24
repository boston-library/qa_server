class Bpldc::License < ApplicationRecord
  validates :label, presence: true

  def self.all_for_api
    self.all.map { |rec| rec.as_json.slice('label', 'uri').compact }
  end
end
