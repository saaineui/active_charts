module ActiveCharts
  class XYChart < RectangularChart
    OFFSET = 6
    
    def initialize(collection, options = {})
      super
      
      section_calcs
      tick_calcs
    end
    
    attr_reader :x_labels, :y_labels, :x_min, :x_max, :y_min, :y_max,
                :x_label_y, :y_label_x, :x_ticks, :y_ticks, :section_width, :section_height
    
    def side_label_text_tags
      y_labels.map.with_index do |label, index| 
        label = formatted_val(label, data_formatters[1])
        
        tag.text(label, x: y_label_x, y: y_tick_y(index), class: 'ac-y-label')
      end.join
    end

    def bottom_label_text_tags
      x_labels.map.with_index do |label, index| 
        label = formatted_val(label, data_formatters[0])
        classes = 'ac-x-label'
        classes += ' anchor_start' if index.zero?
      
        tag.text(label, x: x_tick_x(index), y: x_label_y, class: classes)
      end.join
    end

    private
    
    def prereq_calcs
      @collection = collection.map do |row| 
        row.map { |x, y| [Util.safe_to_dec(x), Util.safe_to_dec(y)] } 
      end
    end
    
    def values_calcs
      @collection.flatten(1)
    end
      
    def width_calcs(values)
      @grid_width = svg_width - MARGIN * 4
      @x_min, @x_max, x_step = Util.scale(values.min, values.max)
      @x_labels = (x_min..x_max).step(x_step)
    end
    
    def height_calcs(values)
      @grid_height = svg_height - label_height * 2
      @y_min, @y_max, y_step = Util.scale(values.min, values.max)
      @y_labels = (y_min..y_max).step(y_step)
    end
    
    def section_calcs
      @section_width = grid_width.to_d / (x_labels.count - 1)
      @section_height = grid_height.to_d / (y_labels.count - 1)
    end
    
    def tick_calcs
      @x_label_y = x_axis_y
      @y_label_x = y_axis_x
      @x_ticks = (1..x_labels.size - 2).map { |i| x_tick_x(i) }
      @y_ticks = (1..y_labels.size - 2).map { |i| y_tick_y(i) }
    end
    
    def x_axis_y
      grid_height + label_height * 1.5
    end
    
    def y_axis_x
      grid_width + OFFSET
    end
      
    def x_tick_x(index)
      section_width * index
    end
    
    def y_tick_y(index)
      return label_height + TOP_LEFT_OFFSET if index.eql?(y_labels.count - 1)
      
      (section_height * (y_labels.count - 1 - index)).round(6)
    end
  end
end
