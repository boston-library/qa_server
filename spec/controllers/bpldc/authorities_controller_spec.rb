# frozen_string_literal: true

require_relative './shared/authorities_shared'
RSpec.describe Bpldc::AuthoritiesController do
  describe 'GET index' do
    before(:each) { get :index }
    it_behaves_like 'authorities_index_shared'
  end

  describe 'GET subjects' do
    before(:each) { get :subjects }
    it_behaves_like 'authorities_index_shared'
  end

  describe 'GET genres' do
    before(:each) { get :genres }
    it_behaves_like 'authorities_index_shared'
  end

  describe 'GET names' do
    before(:each) { get :names }
    it_behaves_like 'authorities_index_shared'
  end

  describe 'GET geographics' do
    before(:each) { get :geographics }
    it_behaves_like 'authorities_index_shared'
  end
end
