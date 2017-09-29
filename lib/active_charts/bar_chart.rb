module ActiveCharts
  class BarChart < RectangularChart
    DEFAULT_BAR_WIDTH = 40
    
    attr_reader :x_labels, :series_labels, :bar_width, :bars_count, :x_offset, :y_offset, 
                :section_width, :max_bar_height, :max_values, :y_multipliers
    
    def chart_svg_tag
      opts = { 
        xmlns: 'http://www.w3.org/2000/svg',
        style: "width: #{svg_width}px; height: auto;",
        viewBox: "0 0 #{svg_width} #{svg_height}",
        class: 'ac-chart ac-bar-chart'
      }

      inner_html = [grid_rect_tag, bars, bottom_label_text_tags].flatten.join('
          ')
      
      tag.svg(inner_html.html_safe, opts)
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
        label = formatted_val(bar[:val], bar[:formatter])
        
        [%(<rect #{tag_options(bar.merge(width: bar_width), whitelist)} />),
         tag.text(label, label_options(bar))]
      end
    end

    def bars_specs
      collection.map.with_index do |row, row_index|
        row.map.with_index do |cell, col_index|
          height = bar_height(cell, col_index)
          x = bar_x(col_index, row_index)
          y = grid_height - height

          { height: height, x: x, y: y, class: bar_classes(col_index), val: cell, 
            formatter: data_formatters[col_index] }
        end
      end
    end
    
    def bottom_label_text_tags
      x_labels.map.with_index do |label, index| 
        tag.text(label, x: section_width * (index + 0.5), y: grid_height + label_height * 1.5)
      end.join
    end

    private

    def process_options(options)
      super
      
      @bar_width = options[:bar_width] || DEFAULT_BAR_WIDTH
      @x_labels = options[:rows] || []
    end
    
    def prereq_calcs
      @bars_count = columns_count * rows_count
    end
    
    def width_calcs(_values)
      @grid_width = @svg_width = compute_svg_width
      @section_width = rows_count.zero? ? svg_width : svg_width / rows_count.to_d
      @x_offset = bar_width / 2
    end
    
    def compute_svg_width
      (bar_width * bars_count) + (rows_count * MARGIN * (1 + columns_count))
    end
    
    def height_calcs(_values)
      @grid_height = svg_height - label_height * 2
      @max_bar_height = grid_height - label_height * 3
      @y_offset = label_height / 2
      @y_multipliers = max_values.map { |max| Util.multiplier(max, max_bar_height) }
    end 
    
    def label_options(bar)
      {
        x: bar[:x] + x_offset,
        y: bar[:y] - y_offset
      }
    end
      
    def bar_classes(col)
      ['ac-bar-chart-bar', series_class(col)].join(' ')
    end
    
    def bar_height(cell, col_index)
      Util.safe_to_dec(cell) * y_multipliers[col_index]
    end
    
    def bar_x(col, row)
      ((bar_width + MARGIN) * Util.grid_index(columns_count, col, row)) + (MARGIN * (row + 1))
    end
  end
end
