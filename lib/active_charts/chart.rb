module ActiveCharts
  class Chart
    def initialize(collection, options = {})
      @collection = collection
      @title = options[:title] || ''
      @extra_css_classes = options[:class] || ''
    end
    
    attr_reader :collection, :title, :extra_css_classes
  end
end
