# frozen_string_literal: true

module Bpldc
  class AuthoritiesController < ApplicationController
    # GET /bpldc/authorities
    def index
      @authorities = Bpldc::Authority.all
      render json: public_attributes
    end

    # GET /bpldc/authorities/subjects
    def subjects
      @authorities = Bpldc::Authority.subjects
      render json: public_attributes
    end

    # GET /bpldc/authorities/subjects
    def genres
      @authorities = Bpldc::Authority.genres
      render json: public_attributes
    end

    # GET /bpldc/authorities/subjects
    def names
      @authorities = Bpldc::Authority.names
      render json: public_attributes
    end

    # GET /bpldc/authorities/subjects
    def geographics
      @authorities = Bpldc::Authority.geographics
      render json: public_attributes
    end

    private

    def public_attributes
      @authorities.map { |rec| rec.slice(:code, :name, :base_url).compact }
    end
  end
end
