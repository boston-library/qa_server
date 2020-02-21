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
Bpldc::Nomenclature.seed_lc_data(bpldc_class: 'Bpldc::ResourceType', lc_url_suffix: 'resourceTypes.json',
                                 ids_to_ignore: %w(unk resourceTypes), auth_code: 'resourceTypes')

### ROLES ###
Bpldc::Nomenclature.seed_lc_data(bpldc_class: 'Bpldc::Role', lc_url_suffix: 'relators.json',
                                 ids_to_ignore: ['relators'], auth_code: 'marcrelator')

