# frozen_string_literal: true

module ActiveCharts
  module Helpers #:nodoc:
    module BarChartHelper
      def bar_chart(collection, options = {})
        BarChart.new(collection, options).to_html
      end
      
      def bar_chart_for(resource_collection, columns = [], options = {})
        return bar_chart([[]], options) unless Util.valid_collection?(resource_collection)
        
        parser = CollectionParser.new(resource_collection, columns, options[:label_column])
        bar_chart(parser.collection, options.merge(series_labels: parser.series_labels, rows: parser.rows))
      end
    end
  end
end
