# frozen_string_literal: true

require_relative './shared/index_shared'
RSpec.describe Bpldc::NomenclaturesController do
  describe 'GET resource_types' do
    before(:each) { get :resource_types }
    it_behaves_like 'bpldc_index_shared'
  end

  describe 'GET roles' do
    before(:each) { get :roles }
    it_behaves_like 'bpldc_index_shared'
  end
end
