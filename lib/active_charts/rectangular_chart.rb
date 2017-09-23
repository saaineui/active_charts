module ActiveCharts
  class RectangularChart < Chart
    TOP_LEFT_OFFSET = 1
    
    def initialize(collection, options = {})
      super
      
      prereq_calcs
      
      values = values_calcs
      
      width_calcs(values.map(&width_filter))
      height_calcs(values.map(&height_filter))
    end
    
    attr_reader :grid_height, :grid_width, :svg_height, :svg_width
    
    def grid_rect_tag
      tag.rect(
        x: TOP_LEFT_OFFSET,
        y: TOP_LEFT_OFFSET,
        height: grid_height - TOP_LEFT_OFFSET * 2, 
        width: grid_width - TOP_LEFT_OFFSET * 2, 
        class: 'grid'
      )
    end
    
    private

    def process_options(options)
      super
      
      @series_labels = options[:columns] || []
      @grid_width = @svg_width = options[:width] || MARGIN * 30
      @grid_height = @svg_height = options[:height] || MARGIN * 20
    end
    
    def prereq_calcs; end
    
    def values_calcs
      []
    end
    
    def width_filter; end

    def height_filter; end

    def width_calcs(_values); end
    
    def height_calcs(_values); end
  end
end
