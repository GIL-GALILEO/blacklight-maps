# frozen_string_literal: true

require 'blacklight'
require 'blacklight/maps/blacklight_maps_helper'


module Blacklight
  module Maps
    class Engine < Rails::Engine
      # Set some default configurations
      initializer 'blacklight.maps.default_config' do |_app|
        Blacklight::Configuration.default_values[:view].maps.geojson_field = 'geojson_ssim'
        Blacklight::Configuration.default_values[:view].maps.placename_property = 'placename'
        Blacklight::Configuration.default_values[:view].maps.coordinates_field = 'coordinates_srpt'
        Blacklight::Configuration.default_values[:view].maps.search_mode = 'placename' # or 'coordinates'
        Blacklight::Configuration.default_values[:view].maps.spatial_query_dist = 0.5
        Blacklight::Configuration.default_values[:view].maps.placename_field = 'subject_geo_ssim'
        Blacklight::Configuration.default_values[:view].maps.coordinates_facet_field = 'coordinates_ssim'
        Blacklight::Configuration.default_values[:view].maps.facet_mode = 'geojson' # or 'coordinates'
        Blacklight::Configuration.default_values[:view].maps.tileurl = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
        Blacklight::Configuration.default_values[:view].maps.mapattribution = 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>'
        Blacklight::Configuration.default_values[:view].maps.maxzoom = 18
        Blacklight::Configuration.default_values[:view].maps.show_initial_zoom = 5
      end

      # Add our helpers
      initializer 'blacklight.maps.helpers' do |_app|
        ActiveSupport.on_load(:action_view) do
          include Blacklight::Maps::BlacklightMapsHelper
        end
      end

      # Load rake tasks
      rake_tasks do
        Dir.glob(File.expand_path('../../railties/*.rake', __dir__)).each do |railtie|
          load railtie
        end
      end
    end
  end
end
