# frozen_string_literal: true

require 'active_support/core_ext/string/output_safety'

module ActiveCharts
  # = Active Charts Chart Helpers
  module Helpers #:nodoc:
    # Provides methods to generate HTML and SVG charts programmatically.
    module ChartHelper
      def bar_chart(collection, options = {})
        chart = BarChart.new(collection, options)
        chart.to_html
      end
      
      def bar_chart_for(resource_collection, columns = [], options = {})
        resource = resource_collection.first.class
        columns = Util.valid_columns(resource, columns)
        label_column = options[:label_column] || Util.label_column(resource)
        
        collection = resource_collection.map do |record| 
          columns.map{ |column| record.send(column) }
        end
        rows = resource_collection.map { |record| record.send(label_column) }
        columns = columns.map(&:to_s).map(&:titleize)
        
        bar_chart(collection, options.merge({ columns: columns, rows: rows }))
      rescue
        nil
      end
    end
  end
end
