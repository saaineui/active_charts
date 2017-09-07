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
      
      # def bar_chart_for(resource, columns)
      # end
    end
  end
end
