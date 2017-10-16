# frozen_string_literal: true

module ActiveCharts
  module Helpers #:nodoc:
    module ScatterPlotHelper
      def scatter_plot(collection, options = {})
        ScatterPlot.new(collection, options).to_html
      end
      
      def scatter_plot_for(resource_collection, columns = [], options = {})
        return scatter_plot([[]], options) unless Util.valid_collection?(resource_collection)
        
        parser = CollectionParser.new(resource_collection, columns, options[:label_column])
        scatter_plot(parser.xy_collection, options.merge(series_labels: parser.xy_series_labels, rows: parser.rows))
      end
    end
  end
end
