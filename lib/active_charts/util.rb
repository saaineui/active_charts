module ActiveCharts
  # @private
  module Util
    def max_values(array_of_arrays)
      return [] if array_of_arrays.empty?
      
      maxes = array_of_arrays.pop.map { |cell| safe_to_dec(cell) }
      
      array_of_arrays.each do |row|
        row.map { |cell| safe_to_dec(cell) }
           .each_with_index do |val, index|
             maxes[index] = val if index > maxes.count - 1 || val > maxes[index]
           end
      end
      
      maxes
    end
    
    def multiplier(data_value, pixels, precision = 6)
      (pixels / safe_to_dec(data_value)).round(precision)
    end
    
    def safe_to_dec(item)
      item.to_d
    rescue
      0.0
    end
    
    def grid_index(width, x, y)
      width * y + x
    end
    
    module_function :max_values, :multiplier, :safe_to_dec, :grid_index
  end
end
