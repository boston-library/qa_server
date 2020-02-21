# frozen_string_literal: true

class Bpldc::Nomenclature < ApplicationRecord
  validates :id_from_auth, presence: true
  validates :label, presence: true
  validates :type, presence: true

  scope :with_authority, -> { includes(:authority) }

  def self.all_for_api
    all_records = self.with_authority
    all_records.map do |rec|
      auth_code = rec.authority.code
      rec = rec.as_json
      rec['authority_code'] = auth_code
      rec.slice('label', 'id_from_auth', 'authority_code')
    end
  end

  def self.seed_lc_data(bpldc_class: '', lc_url_suffix: '', ids_to_ignore: [], auth_code: nil)
    return false if bpldc_class.nil? || lc_url_suffix.nil? || auth_code.nil?
    puts "Seeding #{bpldc_class} values"
    lc_url = "http://id.loc.gov/vocabulary/#{lc_url_suffix}"
    lc_response = Faraday.get(lc_url)
    lc_data = lc_response.status == 200 ? JSON.parse(lc_response.body) : nil
    return false unless lc_data
    authority = Bpldc::Authority.where(code: auth_code).first
    lc_data.each do |lc_data_hash|
      bpldc_class.constantize.transaction do
        begin
          auth_input = {authority_id: authority.id}
          id_from_auth = lc_data_hash['@id'].split('/').last
          next if ids_to_ignore.include?(id_from_auth)
          auth_input[:id_from_auth] = id_from_auth
          auth_input[:label] = lc_data_hash['http://www.loc.gov/mads/rdf/v1#authoritativeLabel'].first['@value']
          bpldc_class.constantize.where(auth_input).first_or_create!
        rescue StandardError => e
          puts "Failed to seed #{bpldc_class} with the following input #{auth_input.inspect}"
          puts e.inspect
        end
      end
    end
  end
end
