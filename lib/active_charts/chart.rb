require 'action_view/helpers/number_helper'
require 'action_view/helpers/capture_helper'
require 'action_view/helpers/output_safety_helper'
require 'action_view/helpers/tag_helper'

module ActiveCharts
  class Chart
    include ActionView::Helpers::NumberHelper
    include ActionView::Helpers::CaptureHelper
    include ActionView::Helpers::OutputSafetyHelper
    include ActionView::Helpers::TagHelper
    
    def initialize(collection, options = {})
      @collection = Util.array_of_arrays?(collection) ? collection : [[]]
      @title = options[:title] || ''
      @extra_css_classes = options[:class] || ''
      @max_values = Util.max_values(@collection)
      @data_formatters = options[:data_formatters] || []
    end
    
    attr_reader :collection, :title, :extra_css_classes, :max_values, :data_formatters
    
    def to_html
      inner_html = [tag.figcaption(title, class: 'ac-chart-title'), chart_svg_tag, legend_list_tag].join('
          ')
      
      tag.figure(inner_html.html_safe, class: container_classes)
    end
      
    def chart_svg_tag; end
    
    def legend_list_tag; end
    
    private
        
    def container_classes
      ['ac-chart-container', 'ac-clearfix', extra_css_classes].join(' ')
    end
    
    def options(opts, whitelist = nil)
      opts = opts.select { |k, _v| whitelist.include? k.to_s } if whitelist
      tag_builder = TagBuilder.new(self)
      opts.map { |k, v| tag_builder.tag_option(k, v, true) }.join(' ')
    end
    
    def formatted_val(val, formatter)
      case formatter
      when :percent
        number_to_percentage(Util.safe_to_dec(val) * 100)
      when :date
        val.strftime('%F')
      when :rounded
        Util.safe_to_dec(val).round
      else
        number_with_delimiter(val)
      end
    end
  end
end
