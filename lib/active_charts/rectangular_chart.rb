module ActiveCharts
  class RectangularChart < Chart
    TOP_LEFT_OFFSET = 0
    
    def initialize(collection, options = {})
      super
      
      count_calcs
      width_calcs
      height_calcs
    end
    
    attr_reader :grid_height, :grid_width, :svg_height, :svg_width
    
    def grid_rect_tag
      %(<rect #{tag_options(height: grid_height, width: grid_width, class: 'grid')} />)
    end
    
    private

    def process_options(options)
      super
      
      @svg_width = options[:width] || MARGIN * 30
      @svg_height = options[:height] || MARGIN * 20
    end
    
    def count_calcs; end
    
    def width_calcs; end
    
    def height_calcs; end
  end
end
