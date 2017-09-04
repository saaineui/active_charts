# frozen_string_literal: true

require 'active_support/core_ext/string/output_safety'

module ActiveCharts
  # = Active Charts Chart Helpers
  module Helpers #:nodoc:
    # Provides methods to generate SVG tags programmatically.
    module ChartHelper
      def bar_chart(collection, options = {})
        bc = BarChart.new(collection, options)
        
        output = [bc.figure_open_tag, bc.svg_open_tag]
        output += bc.bars
        output << bc.bottom_label_text_tags
        
        output << '</svg>'
        output << '</figure>'
        
        output << bc.legend_list_tag
        
        output.join('
          ').html_safe
      end
      
      # def bar_chart_for(resource, columns)
      # end
    end
  end
end
