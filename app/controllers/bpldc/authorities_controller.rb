# frozen_string_literal: true

module Bpldc
  class AuthoritiesController < ApplicationController
    # GET /bpldc/authorities
    def index
      @authorities = Bpldc::Authority.public_attributes.all
      render json: results_for_api
    end

    # GET /bpldc/authorities/subjects
    def subjects
      @authorities = Bpldc::Authority.public_attributes.subjects
      render json: results_for_api
    end

    # GET /bpldc/authorities/subjects
    def genres
      @authorities = Bpldc::Authority.public_attributes.genres
      render json: results_for_api
    end

    # GET /bpldc/authorities/subjects
    def names
      @authorities = Bpldc::Authority.public_attributes.names
      render json: results_for_api
    end

    # GET /bpldc/authorities/subjects
    def geographics
      @authorities = Bpldc::Authority.public_attributes.geographics
      render json: results_for_api
    end

    private

    def results_for_api
      @authorities.map { |rec| rec.as_json.compact }
    end
  end
end
