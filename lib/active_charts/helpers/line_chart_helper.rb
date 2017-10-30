# frozen_string_literal: true

require 'active_charts/util'

module ActiveCharts
  module Helpers #:nodoc:
    module LineChartHelper
      def line_chart(collection, options = {})
        LineChart.new(collection, options).to_html
      end
      
      def line_chart_for(resource_collection, columns = [], options = {})
        return line_chart([[]], options) unless Util.valid_collection?(resource_collection)
        
        parser = CollectionParser.new(resource_collection, columns, options[:label_column])
        options = options.merge(series_labels: parser.xy_series_labels, rows: parser.rows)
        
        line_chart(parser.xy_collection, options)
      end
    end
  end
end
