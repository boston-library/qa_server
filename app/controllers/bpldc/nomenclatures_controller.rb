# frozen_string_literal: true

module Bpldc
  class NomenclaturesController < ApplicationController
    # GET /bpldc/resource_types
    def resource_types
      @objects = Bpldc::ResourceType.all_for_api
      render json: @objects
    end
  end
end
