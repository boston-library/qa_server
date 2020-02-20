# frozen_string_literal: true

module Bpldc
  class AuthoritiesController < ApplicationController
    # GET /bpldc/authorities
    def index
      @authorities = Bpldc::Authority.all
      render json: @authorities
    end

    # GET /bpldc/authorities/subjects
    def subjects
      @authorities = Bpldc::Authority.subjects
      render json: @authorities
    end

    # GET /bpldc/authorities/subjects
    def genres
      @authorities = Bpldc::Authority.genres
      render json: @authorities
    end

    # GET /bpldc/authorities/subjects
    def names
      @authorities = Bpldc::Authority.names
      render json: @authorities
    end

    # GET /bpldc/authorities/subjects
    def geographics
      @authorities = Bpldc::Authority.geographics
      render json: @authorities
    end
  end
end
