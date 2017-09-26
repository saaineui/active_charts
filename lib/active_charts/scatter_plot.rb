module ActiveCharts
  class ScatterPlot < XYChart
    attr_reader :dot_labels
    
    def chart_svg_tag
      inner_html = [grid_rect_tag, ticks(x_ticks, y_ticks), dots, 
                    side_label_text_tags, bottom_label_text_tags].flatten.join('
          ')
      
      tag.svg(inner_html.html_safe, svg_options)
    end
    
    def dots
      whitelist = %w[cx cy class]
      
      dots_specs.flatten.map do |dot| 
        [%(<circle #{tag_options(dot, whitelist)} />),
         tag.text(dot[:label], x: dot[:cx] + OFFSET, y: dot[:cy] - OFFSET, class: 'ac-scatter-plot-label')]
      end
    end

    def dots_specs
      collection.map.with_index do |row, row_index|
        row.map.with_index do |cell, col_index|
          dot_spec(cell, row_index, col_index)
        end
      end
    end
    
    private
    
    def process_options(options)
      super
      
      @dot_labels = options[:rows] || []
    end
    
    def dot_spec(cell, row_index, col_index)
      { cx: dot_cx(cell.first), cy: dot_cy(cell.last), class: dot_classes(col_index), 
        label: dot_labels[row_index] }
    end
    
    def dot_cx(value)
      Util.scaled_position(value, x_min, x_max, grid_width).round(6)
    end
    
    def dot_cy(value)
      grid_height - Util.scaled_position(value, y_min, y_max, grid_height).round(6)
    end
    
    def dot_classes(col)
      ['ac-scatter-plot-dot', series_class(col)].join(' ')
    end
  end
end
