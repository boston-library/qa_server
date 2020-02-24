# frozen_string_literal: true

RSpec.describe Bpldc::Authority do
  subject { create(:bpldc_authority) }

  describe 'database' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:code).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:base_url).of_type(:string) }
    it { is_expected.to have_db_column(:subjects).of_type(:boolean) }
    it { is_expected.to have_db_column(:genres).of_type(:boolean) }
    it { is_expected.to have_db_column(:names).of_type(:boolean) }
    it { is_expected.to have_db_column(:geographics).of_type(:boolean) }

    it { is_expected.to have_db_index(:subjects) }
    it { is_expected.to have_db_index(:genres) }
    it { is_expected.to have_db_index(:names) }
    it { is_expected.to have_db_index(:geographics) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_uniqueness_of(:code) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:resource_types).
        inverse_of(:authority).
        class_name('Bpldc::ResourceType').
        with_foreign_key(:authority_id).
        dependent(:destroy) }

    it { is_expected.to have_many(:roles).
        inverse_of(:authority).
        class_name('Bpldc::Role').
        with_foreign_key(:authority_id).
        dependent(:destroy) }

    it { is_expected.to have_many(:languages).
        inverse_of(:authority).
        class_name('Bpldc::Language').
        with_foreign_key(:authority_id).
        dependent(:destroy) }
=begin
    it { is_expected.to have_many(:genres).
        inverse_of(assoc_options[:inverse_of]).
        class_name('Curator::ControlledTerms::Genre').
        with_foreign_key(assoc_options[:foreign_key]).
        dependent(assoc_options[:dependent]) }

    it { is_expected.to have_many(:licenses).
        inverse_of(assoc_options[:inverse_of]).
        class_name('Curator::ControlledTerms::License').
        with_foreign_key(assoc_options[:foreign_key]).
        dependent(assoc_options[:dependent]) }
=end
  end
end
