# frozen_string_literal: true

module ActiveCharts
  # = Active Charts Chart Helpers
  module Helpers #:nodoc:
    # Provides methods to generate HTML and SVG charts programmatically.
    module ChartHelper
      def bar_chart(collection, options = {})
        BarChart.new(collection, options).to_html
      end
      
      def bar_chart_for(resource_collection, columns = [], options = {})
        return bar_chart([[]], options) unless Util.valid_collection?(resource_collection)
        
        resource = resource_collection.first.class
        columns = Util.valid_columns(resource, columns)
        label_column = options[:label_column] || Util.label_column(resource)
        
        collection = resource_collection.pluck(*columns)
        rows = resource_collection.pluck(label_column)
        columns = columns.map(&:to_s).map(&:titleize)
        
        bar_chart(collection, options.merge(columns: columns, rows: rows))
      end

      def scatter_plot(collection, options = {})
        ScatterPlot.new(collection, options).to_html
      end
    end
  end
end
