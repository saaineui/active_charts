require 'action_view/helpers/number_helper'

module ActiveCharts
  class BarChart < Chart
    include ActionView::Helpers::NumberHelper
    
    MARGIN = 20
    DEFAULT_BAR_WIDTH = 40
    CSS_CLASSES = %w[a b c d e f].map { |letter| 'series-' + letter }.freeze
    
    def initialize(collection, options = {})
      super
      
      @bar_width = options[:bar_width] || DEFAULT_BAR_WIDTH
      @series_labels = options[:columns] || []
      @x_labels, @collection = extract_labels(collection, options)
      @svg_height = options[:height] || 400
      @label_height = options[:label_height] || 10
    end
    
    attr_reader :x_labels, :series_labels, :bar_width, :svg_height, :label_height
    
    def series_class(index)
      CSS_CLASSES[index % CSS_CLASSES.size]
    end
    
    def columns_count
      @collection.first.count
    end
    
    def rows_count
      @collection.count
    end
    
    def bars_count
      columns_count * rows_count
    end
    
    def max_values
      return [] if @collection.empty?
      
      maxes = @collection.first.map { |cell| Util.safe_to_dec(cell) }
      @collection[1..rows_count - 1].each do |row|
        row.map { |cell| Util.safe_to_dec(cell) }
           .each_with_index do |val, index|
             maxes[index] = val if val > maxes[index]
           end
      end
      
      maxes
    end
    
    def svg_width
      (bar_width * bars_count) + (rows_count * MARGIN * (1 + columns_count))
    end
    
    def grid_height
      svg_height - label_height * 2
    end
    
    def max_bar_height
      grid_height - label_height * 3
    end
    
    def section_width
      rows_count.zero? ? svg_width : svg_width / rows_count.to_d
    end
    
    def figure_open_tag
      "<figure class=\"ac-chart-container ac-clearfix #{extra_css_classes}\">
          <figcaption class=\"ac-chart-title\">#{title}</figcaption>"
    end

    def svg_open_tag
      ['<svg xmlns="http://www.w3.org/2000/svg"',
       "style=\"width: #{svg_width}px; height: #{svg_height}px;\"",
       "viewBox=\"0 0 #{svg_width} #{svg_height}\"",
       'class="ac-chart ac-bar-chart">'].join(' ') + "
          <rect height=#{grid_height} width=#{svg_width} class=\"grid\" />"
    end
    
    def legend_list_tag
      ['<ul class="ac-chart ac-series-legend">',
       series_labels.map.with_index do |label, index| 
         "<li class=\"#{series_class(index)}\">#{label}</li>" 
       end, 
       '</ul>'].flatten.join
    end
    
    def bars
      x_offset = bar_width / 2

      bars_specs.flatten.map do |bar| 
        ["<rect height=#{bar[:height]} x=#{bar[:x]} y=#{bar[:y]} class=\"ac-bar-chart-bar #{series_class(bar[:col])}\" />",
         "<text x=#{bar[:x] + x_offset} y=#{bar[:y] - label_height}>",
         number_with_delimiter(bar[:val]),
         '</text>']
      end
    end

    def bars_specs
      bar_x = 0
      multipliers = y_multipliers

      collection.map.with_index do |row, row_index|
        bar_x += MARGIN

        row.map.with_index do |cell, col_index|
          bar_height = Util.safe_to_dec(cell) * multipliers[col_index]
          bar_x += bar_width + MARGIN unless [row_index, col_index].all?(&:zero?)
          bar_y = grid_height - bar_height

          { height: bar_height, x: bar_x, y: bar_y, col: col_index, val: cell }
        end
      end
    end
    
    def bottom_label_text_tags
      offset = section_width / 2
      
      x_labels.map.with_index do |label, index| 
        "<text x=#{section_width * index + offset} y=#{grid_height + label_height * 1.5}>#{label}</text>"
      end.join
    end

    def y_multipliers
      max_values.map { |max| Util.multiplier(max, max_bar_height) }
    end
      
    private
    
    def extract_labels(collection, options)
      return [[], collection] unless options.key?(:contains_label) && options[:contains_label]
      
      [collection.map(&:first), collection.map { |row| row[1..row.size - 1] }]
    end
  end
end
