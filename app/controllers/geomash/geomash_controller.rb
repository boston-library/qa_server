# frozen_string_literal: true

module Geomash
  class GeomashController < ApplicationController
    # GET /geomash/tgn/:id
    def tgn
      begin
        @geomash_data = Geomash::TGN.get_tgn_data(params[:id])
        return_or_not_found
      rescue StandardError => error
        error_response(error, 400)
      end
    end

    # GET /geomash/geonames/:id
    def geonames
      begin
        @geomash_data = Geomash::Geonames.get_geonames_data(params[:id])
        return_or_not_found
      rescue StandardError => error
        error_response(error, 400)
      end
    end

    # GET /geomash/parse
    def parse
      begin
        @geomash_data = Geomash.parse(params[:term], params[:parse_term] == 'true' ? true : false)
        return_or_not_found
      rescue StandardError => error
        error_response(error, 400)
      end
    end

    # GET /geomash/state_town_lookup
    # WARNING: this only works for MA towns
    def state_town_lookup
      begin
        @geomash_data = Geomash::TownLookup.state_town_lookup(params[:state_key], params[:term])
        @geomash_data = { tgn_id: @geomash_data } if @geomash_data
        return_or_not_found
      rescue StandardError => error
        error_response(error, 400)
      end
    end

    private

    def return_or_not_found
      if @geomash_data.present?
        render json: @geomash_data.compact
      else
        error_response('no data found', 404)
      end
    end

    def error_response(error, response_code)
      render json: { error: "#{error}" }, status: response_code
    end
  end
end