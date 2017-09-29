module ActiveCharts
  class ScatterPlot < RectangularChart
    OFFSET = 6
    
    def initialize(collection, options = {})
      super
      
      tick_calcs
    end
    
    attr_reader :x_labels, :y_labels, :series_labels, :dot_labels, :x_min, :x_max, :y_min, :y_max,
                :x_label_y, :y_label_x, :x_ticks, :y_ticks, :section_width, :section_height
    
    def chart_svg_tag
      inner_html = [grid_rect_tag, ticks(x_ticks, y_ticks), dots, 
                    side_label_text_tags, bottom_label_text_tags].flatten.join('
          ')
      
      tag.svg(
        inner_html.html_safe, 
        svg_options
      )
    end
    
    def legend_list_tag
      list_items = series_labels.map.with_index do |label, index| 
        tag.li(label, class: series_class(index)) 
      end
      
      tag.ul(list_items.join.html_safe, class: 'ac-chart ac-series-legend')
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
    
    def side_label_text_tags
      y_labels.map.with_index do |label, index| 
        tag.text(label, x: y_label_x, y: y_tick(index), class: 'ac-y-label')
      end.join
    end

    def bottom_label_text_tags
      x_labels.map.with_index do |label, index| 
        classes = 'ac-x-label'
        classes += ' anchor_start' if index.zero?
      
        tag.text(label, x: x_tick(index), y: x_label_y, class: classes)
      end.join
    end

    private
    
    def process_options(options)
      super
      
      @dot_labels = options[:rows] || []
    end
    
    def prereq_calcs
      @collection = @collection.map { |row| row.map { |x, y| [x.to_d, y.to_d] } }
    end
    
    def values_calcs
      @collection.flatten(1)
    end
      
    def width_calcs(values)
      @grid_width = svg_width - MARGIN * 3
      @x_min, @x_max, x_step = Util.scale(values.min, values.max)
      @x_labels = (x_min..x_max).step(x_step)
      @section_width = grid_width.to_d / (x_labels.count - 1)
    end
    
    def height_calcs(values)
      @grid_height = svg_height - label_height * 2
      @y_min, @y_max, y_step = Util.scale(values.min, values.max)
      @y_labels = (y_min..y_max).step(y_step)
      @section_height = grid_height.to_d / (y_labels.count - 1)
    end 
    
    def tick_calcs
      @x_label_y = grid_height + label_height * 1.5
      @y_label_x = grid_width + MARGIN
      @x_ticks = (1..x_labels.size - 2).map { |i| x_tick(i) }
      @y_ticks = (1..y_labels.size - 2).map { |i| y_tick(i) }
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
    
    def x_tick(index)
      section_width * index
    end
    
    def y_tick(index)
      (section_height * (y_labels.count - 1 - index)).round(6)
    end
    
    def svg_options
      { xmlns: 'http://www.w3.org/2000/svg', style: "width: #{svg_width}px; height: auto;",
        viewBox: "0 0 #{svg_width} #{svg_height}", class: 'ac-chart ac-scatter-plot' }
    end
  end
end
