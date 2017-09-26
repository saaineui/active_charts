# frozen_string_literal: true

module ActiveCharts
  # = Active Charts Chart Helpers
  module Helpers #:nodoc:
    # Provides methods to generate HTML and SVG charts programmatically.
    module ChartHelper
      class CollectionParser
        def initialize(resource_collection, columns, label_column)
          resource = resource_collection.first.class
          
          @label_column = label_column || Util.label_column(resource)
          @columns = Util.valid_columns(resource, columns)
          @rows = resource_collection.pluck(@label_column)
          @collection = resource_collection.pluck(*@columns)
        end
        
        attr_reader :collection, :columns, :rows, :label_column
        
        def series_labels
          columns.map(&:to_s).map(&:titleize)
        end
        
        def xy_series_labels
          series_labels_size = series_labels.size.even? ? series_labels.size : series_labels.size - 1
          
          (0..series_labels_size - 1).step(2).map do |index|
            "#{series_labels[index]} vs. #{series_labels[index + 1]}"
          end
        end
        
        def xy_collection
          collection.map do |row|
            row_size = row.count.even? ? row.size : row.size - 1
            
            (0..row_size - 1).step(2).map do |index|
              [row[index], row[index + 1]] if row[index] && row[index + 1]
            end.compact
          end
        end
      end
      
      def bar_chart(collection, options = {})
        BarChart.new(collection, options).to_html
      end
      
      def bar_chart_for(resource_collection, columns = [], options = {})
        return bar_chart([[]], options) unless Util.valid_collection?(resource_collection)
        
        parser = CollectionParser.new(resource_collection, columns, options[:label_column])
        bar_chart(parser.collection, options.merge(series_labels: parser.series_labels, rows: parser.rows))
      end

      def scatter_plot(collection, options = {})
        ScatterPlot.new(collection, options).to_html
      end
      
      def scatter_plot_for(resource_collection, columns = [], options = {})
        return bar_chart([[]], options) unless Util.valid_collection?(resource_collection)
        
        parser = CollectionParser.new(resource_collection, columns, options[:label_column])
        scatter_plot(parser.xy_collection, options.merge(series_labels: parser.xy_series_labels, rows: parser.rows))
      end
    end
  end
end
