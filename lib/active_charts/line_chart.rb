module ActiveCharts
  class LineChart < XYChart
    attr_reader :line_labels
    
    def chart_svg_tag
      inner_html = [grid_rect_tag, ticks(x_ticks, y_ticks), lines, line_label_tags, 
                    side_label_text_tags, bottom_label_text_tags].flatten.join('
          ')
      
      tag.svg(inner_html.html_safe, svg_options)
    end
    
    def lines
      dots_specs.map.with_index do |line_dots, index|
        d = line_dots.map do |dot| 
          [dot[:cx], dot[:cy]].join(' ') 
        end
        
        tag.path('', d: 'M' + d.join(' L '), class: line_classes(index))
      end
    end
    
    def line_label_tags
      dots_specs.flatten.map do |dot| 
        tag.text(dot[:label], x: dot[:cx] + OFFSET, y: dot[:cy] - OFFSET, class: label_classes)
      end
    end

    def dots_specs
      (0..columns_count - 1).map do |col_index|
        collection.map.with_index do |row, row_index|
          dot_spec(row[col_index], row_index)
        end
      end
    end
    
    private
    
    def process_options(options)
      super
      
      @line_labels = options[:rows] || []
    end
    
    def dot_spec(cell, row_index)
      { cx: dot_cx(cell.first), cy: dot_cy(cell.last), label: line_labels[row_index] }
    end
    
    def dot_cx(value)
      Util.scaled_position(value, x_min, x_max, grid_width).round(6)
    end
    
    def dot_cy(value)
      grid_height - Util.scaled_position(value, y_min, y_max, grid_height).round(6)
    end
    
    def line_classes(col)
      ['ac-line-chart-line', series_class(col)].join(' ')
    end
  end
end
