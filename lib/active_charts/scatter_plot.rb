module ActiveCharts
  class ScatterPlot < RectangularChart
    def initialize(collection, options = {})
      super
      
      force_collection_to_d
      xy_pairs = @collection.flatten(1)
      x_calcs(xy_pairs.map(&:first))
      y_calcs(xy_pairs.map(&:last))
    end
    
    attr_reader :x_labels, :y_labels, :series_labels, :dot_labels, :x_min, :x_max, :y_min, :y_max
    
    def chart_svg_tag
      opts = { 
        xmlns: 'http://www.w3.org/2000/svg',
        style: "width: #{svg_width}px; height: auto;",
        viewBox: "0 0 #{svg_width} #{svg_height}",
        class: 'ac-chart ac-scatter-plot'
      }

      inner_html = [grid_rect_tag, dots, side_label_text_tags, bottom_label_text_tags].flatten.join('
          ')
      
      tag.svg(inner_html.html_safe, opts)
    end
    
    def grid_rect_tag
      %(<rect #{tag_options(height: grid_height, width: grid_width, class: 'grid')} />)
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
         tag.text(dot[:label], x: dot[:cx], y: dot[:cy], class: 'ac-scatter-plot-label')]
      end
    end

    def dots_specs
      collection.map.with_index do |row, row_index|
        row.map.with_index do |cell, col_index|
          cx = Util.scaled_position(cell.first, x_min, x_max, grid_width)
          cy = grid_height - Util.scaled_position(cell.last, y_min, y_max, grid_height)

          { cx: cx.round(6), cy: cy.round(6), class: dot_classes(col_index), 
            label: dot_labels[row_index] }
        end
      end
    end
    
    def side_label_text_tags
      section_height = grid_height.to_d / (y_labels.count - 1)
      
      y_labels.map.with_index do |label, index| 
        tag.text(
          label, 
          x: grid_width + MARGIN, 
          y: (section_height * (y_labels.count - 1 - index)).round(6), 
          class: 'ac-y-label'
        )
      end.join
    end

    def bottom_label_text_tags
      section_width = grid_width.to_d / (x_labels.count - 1)
      
      x_labels.map.with_index do |label, index| 
        tag.text(label, x: section_width * index, y: grid_height + label_height * 1.5)
      end.join
    end

    private
    
    def process_options(options)
      super
      
      @series_labels = options[:columns] || []
      @dot_labels = options[:rows] || []
    end
    
    def force_collection_to_d
      @collection = @collection.map { |row| row.map { |x, y| [x.to_d, y.to_d] } }
    end
      
    def x_calcs(values)
      @grid_width = svg_width - MARGIN * 2
      @x_min, @x_max, x_step = Util.scale(values.min, values.max)
      @x_labels = (x_min..x_max).step(x_step)
    end
    
    def y_calcs(values)
      @grid_height = svg_height - label_height * 2
      @y_min, @y_max, y_step = Util.scale(values.min, values.max)
      @y_labels = (y_min..y_max).step(y_step)
    end 
      
    def dot_classes(col)
      ['ac-scatter-plot-dot', series_class(col)].join(' ')
    end
  end
end
