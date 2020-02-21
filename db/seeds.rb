# frozen_string_literal: true

### AUTHORITIES ###
AUTHORITY_INPUTS = [
    { code: 'aat', base_url: 'http://vocab.getty.edu/aat',
      name: 'Art and Architecture Thesaurus', subjects: true, genres: true },
    { code: 'geonames', base_url: 'http://sws.geonames.org',
      name: 'GeoNames', geographics: true },
    { code: 'gmgpc', base_url: 'http://id.loc.gov/vocabulary/graphicMaterials',
      name: 'Thesaurus for Graphic Materials', genres: true },
    { code: 'iso639-2', base_url: 'http://id.loc.gov/vocabulary/iso639-2',
      name: 'ISO639-2 Languages' },
    { code: 'lcgft', base_url: 'http://id.loc.gov/authorities/genreForms',
      name: 'Library of Congress Genre/Form Terms', genres: true },
    { code: 'lctgm', base_url: 'http://id.loc.gov/vocabulary/graphicMaterials',
      name: 'Thesaurus for Graphic Materials', subjects: true, genres: true },
    { code: 'lcsh', base_url: 'http://id.loc.gov/authorities/subjects',
      name: 'Library of Congress Subject Headings', subjects: true, genres: true, geographics: true },
    { code: 'local', name: 'local', subjects: true, genres: true, names: true },
    { code: 'naf', base_url: 'http://id.loc.gov/authorities/names',
      name: 'Library of Congress Name Authority File', subjects: true, names: true },
    { code: 'marcgt', base_url: 'http://id.loc.gov/vocabulary/genreFormSchemes/marcgt',
      name: 'MARC genre terms', genres: true },
    { code: 'marcrelator', base_url: 'http://id.loc.gov/vocabulary/relators',
      name: 'MARC Relators Scheme' },
    { code: 'rbbin', base_url: 'http://id.loc.gov/vocabulary/genreFormSchemes/rbbin',
      name: 'RBMS Controlled Vocabularies: Binding Terms', genres: true },
    { code: 'rbgenr', base_url: 'http://id.loc.gov/vocabulary/genreFormSchemes/rbgenr',
      name: 'RBMS Controlled Vocabularies: Genre Terms', genres: true },
    { code: 'rbpap', base_url: 'http://id.loc.gov/vocabulary/genreFormSchemes/rbpap',
      name: 'RBMS Controlled Vocabularies: Paper Terms', genres: true },
    { code: 'rbpri', base_url: 'http://id.loc.gov/vocabulary/genreFormSchemes/rbpri',
      name: 'RBMS Controlled Vocabularies: Printing & Publishing Evidence', genres: true },
    { code: 'rbprov', base_url: 'http://id.loc.gov/vocabulary/genreFormSchemes/rbprov',
      name: 'RBMS Controlled Vocabularies: Provenance Evidence', genres: true },
    { code: 'rbpub', base_url: 'http://id.loc.gov/vocabulary/genreFormSchemes/rbpub',
      name: 'RBMS Controlled Vocabularies: Printing & Publishing Evidence', genres: true },
    { code: 'rbtyp', base_url: 'http://id.loc.gov/vocabulary/genreFormSchemes/rbtyp',
      name: 'RBMS Controlled Vocabularies: Type Evidence', genres: true },
    { code: 'resourceTypes', base_url: 'http://id.loc.gov/vocabulary/resourceTypes',
      name: 'Resource Types Scheme' },
    { code: 'tgn', base_url: 'http://vocab.getty.edu/tgn',
      name: 'Thesaurus of Geographic Names', geographics: true },
    { code: 'ulan', base_url: 'http://vocab.getty.edu/ulan',
      name: 'Getty Union List of Artist Names', subjects: true, names: true }
].freeze

AUTHORITY_INPUTS.each do |auth_input|
  Bpldc::Authority.transaction do
    begin
      puts "Seeding authority with attributes #{auth_input.inspect}"
      Bpldc::Authority.where(auth_input).first_or_create!
    rescue StandardError => e
      puts "Failed to seed Authority Record with the following input #{auth_input.inspect}"
      puts e.inspect
    end
  end
end

### RESOURCE TYPES ###
puts "Seeding ResourceType values"
lc_url = "http://id.loc.gov/vocabulary/resourceTypes.json"
lc_response = Faraday.get(lc_url)
lc_data = lc_response.status == 200 ? JSON.parse(lc_response.body) : nil
if lc_data
  authority = Bpldc::Authority.where(code: 'marcrelator').first
  ids_to_ignore = %w(resourceTypes unk)
  lc_data.each do |lc_data_hash|
    Bpldc::ResourceType.transaction do
      begin
        auth_input = {authority_id: authority.id}
        id_from_auth = lc_data_hash['@id'].split('/').last
        next if ids_to_ignore.include?(id_from_auth)
        auth_input[:id_from_auth] = id_from_auth
        auth_input[:label] = lc_data_hash['http://www.w3.org/2004/02/skos/core#prefLabel'].first['@value']
        Bpldc::ResourceType.where(auth_input).first_or_create!
      rescue StandardError => e
        puts "Failed to seed ResourceType with the following input #{auth_input.inspect}"
        puts e.inspect
      end
    end
  end
end
