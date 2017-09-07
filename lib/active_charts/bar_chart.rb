module ActiveCharts
  class BarChart < Chart
    MARGIN = 20
    DEFAULT_BAR_WIDTH = 40
    CSS_CLASSES = %w[a b c d e f].map { |letter| 'series-' + letter }.freeze
    
    def initialize(collection, options = {})
      super
      
      @rows_count = @collection.count
      @columns_count = rows_count.positive? ? @collection.first.count : 0
      @bars_count = columns_count * rows_count
      
      process_options(options)
      process_dimensions
      process_computed
    end
    
    attr_reader :x_labels, :series_labels, :bar_width, :svg_height, :label_height, 
                :rows_count, :columns_count, :bars_count, :max_values, :x_offset, :y_offset,
                :svg_width, :section_width, :grid_height, :max_bar_height, :max_values, :y_multipliers
    
    def chart_svg_tag
      opts = { 
        xmlns: 'http://www.w3.org/2000/svg',
        style: "width: #{svg_width}px; height: #{svg_height}px;",
        viewBox: "0 0 #{svg_width} #{svg_height}",
        class: 'ac-chart ac-bar-chart'
      }

      inner_html = [grid_rect_tag, bars, bottom_label_text_tags].flatten.join('
          ')
      
      tag.svg(inner_html.html_safe, opts)
    end
    
    def grid_rect_tag
      %(<rect #{options(height: grid_height, width: svg_width, class: 'grid')} />)
    end
    
    def legend_list_tag
      list_items = series_labels.map.with_index do |label, index| 
        tag.li(label, class: series_class(index)) 
      end
      
      tag.ul(list_items.join.html_safe, class: 'ac-chart ac-series-legend')
    end
    
    def bars
      whitelist = %w[width height x y class]
      
      bars_specs.flatten.map do |bar| 
        [%(<rect #{options(bar.merge(width: bar_width), whitelist)} />),
         tag.text(number_with_delimiter(bar[:val]), x: bar[:x] + x_offset, y: bar[:y] - y_offset)]
      end
    end

    def bars_specs
      collection.map.with_index do |row, row_index|
        row.map.with_index do |cell, col_index|
          height = Util.safe_to_dec(cell) * y_multipliers[col_index]
          x = bar_x(col_index, row_index)
          y = grid_height - height

          { height: height, x: x, y: y, class: bar_classes(col_index), val: cell }
        end
      end
    end
    
    def bottom_label_text_tags
      offset = section_width / 2
      
      x_labels.map.with_index do |label, index| 
        tag.text(label, x: section_width * index + offset, y: grid_height + label_height * 1.5)
      end.join
    end

    private

    def process_options(options)
      @bar_width = options[:bar_width] || DEFAULT_BAR_WIDTH
      @series_labels = options[:columns] || []
      @x_labels = options[:rows] || []
      @svg_height = options[:height] || DEFAULT_BAR_WIDTH * 10
      @label_height = options[:label_height] || MARGIN / 2
    end
    
    def process_dimensions
      @svg_width = (bar_width * bars_count) + (rows_count * MARGIN * (1 + columns_count))
      @section_width = rows_count.zero? ? svg_width : svg_width / rows_count.to_d
      @grid_height = svg_height - label_height * 2
      @max_bar_height = grid_height - label_height * 3
    end
    
    def process_computed
      @x_offset = bar_width / 2
      @y_offset = label_height / 2
      @max_values = Util.max_values(@collection.dup)
      @y_multipliers = max_values.map { |max| Util.multiplier(max, max_bar_height) }
    end 
      
    def bar_classes(col)
      ['ac-bar-chart-bar', series_class(col)].join(' ')
    end
    
    def series_class(index)
      CSS_CLASSES[index % CSS_CLASSES.size]
    end
    
    def bar_x(col, row)
      ((bar_width + MARGIN) * Util.grid_index(columns_count, col, row)) + (MARGIN * (row + 1))
    end
  end
end
