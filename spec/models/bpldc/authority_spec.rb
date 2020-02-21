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
end
