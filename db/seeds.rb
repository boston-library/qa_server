# frozen_string_literal: true

AUTHORITY_INPUTS = [
    { code: 'gmgpc', base_url: 'http://id.loc.gov/vocabulary/graphicMaterials',
      label: 'Thesaurus for Graphic Materials', genre: true },
    { code: 'lctgm', base_url: 'http://id.loc.gov/vocabulary/graphicMaterials',
      label: 'Thesaurus for Graphic Materials', subject: true, genre: true },
    { code: 'naf', base_url: 'http://id.loc.gov/authorities/names',
      label: 'Library of Congress Name Authority File', subject: true, name: true },
    { code: 'lcsh', base_url: 'http://id.loc.gov/authorities/subjects',
      label: 'Library of Congress Subject Headings', subject: true, genre: true, geographic: true },
    { code: 'lcgft', base_url: 'http://id.loc.gov/authorities/genreForms',
      label: 'Library of Congress Genre/Form Terms', genre: true },
    { code: 'iso639-2', base_url: 'http://id.loc.gov/vocabulary/iso639-2',
      label: 'ISO639-2 Languages' },
    { code: 'marcrelator', base_url: 'http://id.loc.gov/vocabulary/relators',
      label: 'MARC Relators Scheme' },
    { code: 'aat', base_url: 'http://vocab.getty.edu/aat',
      label: 'Art and Architecture Thesaurus ', subject: true, genre: true },
    { code: 'tgn', base_url: 'http://vocab.getty.edu/tgn',
      label: 'Thesaurus of Geographic Names', geographic: true },
    { code: 'ulan', base_url: 'http://vocab.getty.edu/ulan',
      label: 'Getty Union List of Artist Names', subject: true, name: true },
    { code: 'geonames', base_url: 'http://sws.geonames.org/', label: 'GeoNames', geographic: true },
    { code: 'resourceTypes', base_url: 'http://id.loc.gov/vocabulary/resourceTypes',
      label: 'Resource Types Scheme' },
    { code: 'marcgt', base_url: 'http://id.loc.gov/vocabulary/genreFormSchemes/marcgt',
      label: 'MARC genre terms', genre: true },
    { code: 'rbgenr', base_url: 'http://id.loc.gov/vocabulary/genreFormSchemes/rbgenr',
      label: 'RBMS Controlled Vocabularies: Genre Terms', genre: true },
    { code: 'rbpri', base_url: 'http://id.loc.gov/vocabulary/genreFormSchemes/rbpri',
      label: 'RBMS Controlled Vocabularies: Printing & Publishing Evidence', genre: true },
    { code: 'rbprov', base_url: 'http://id.loc.gov/vocabulary/genreFormSchemes/rbprov',
      label: 'RBMS Controlled Vocabularies: Provenance Evidence', genre: true },
    { code: 'rbbin', base_url: 'http://id.loc.gov/vocabulary/genreFormSchemes/rbbin',
      label: 'RBMS Controlled Vocabularies: Binding Terms', genre: true },
    { code: 'rbpap', base_url: 'http://id.loc.gov/vocabulary/genreFormSchemes/rbpap',
      label: 'RBMS Controlled Vocabularies: Paper Terms', genre: true },
    { code: 'rbpub', base_url: 'http://id.loc.gov/vocabulary/genreFormSchemes/rbpub',
      label: 'RBMS Controlled Vocabularies: Printing & Publishing Evidence', genre: true },
    { code: 'rbtyp', base_url: 'http://id.loc.gov/vocabulary/genreFormSchemes/rbtyp',
      label: 'RBMS Controlled Vocabularies: Type Evidence', genre: true },
    { code: 'local', label: 'local', subject: true, genre: true, name: true }
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
