module ActiveCharts
  # @private
  module Util
    def multiplier(data_value, pixels, precision = 6)
      (pixels / safe_to_dec(data_value)).round(precision)
    end
    
    def safe_to_dec(item)
      item.to_d
    rescue
      0.0
    end
    
    module_function :multiplier, :safe_to_dec
  end
end
