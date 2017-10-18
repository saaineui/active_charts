module ActiveCharts
  # @private
  module Util
    def max_values(array_of_arrays)
      return [] unless array_of_arrays?(array_of_arrays)
      
      maxes = initialize_maxes(array_of_arrays.first)
      
      array_of_arrays[1..-1].each do |row|
        row.map { |cell| safe_to_dec(cell) }
           .each_with_index do |val, index|
             maxes[index] = val if index > maxes.count - 1 || val > maxes[index]
           end
      end
      
      maxes
    end
    
    def array_of_arrays?(item)
      item.is_a?(Array) && !item.empty? && item.all? { |row| row.is_a?(Array) }
    end
    
    def initialize_maxes(row)
      row.map do |cell| 
        safe_to_dec(cell) <= 0 ? 1 : safe_to_dec(cell) 
      end # solves floating 0 labels bug
    end
    
    def multiplier(data_value, pixels, precision = 6)
      (pixels / safe_to_dec(data_value)).round(precision)
    end
    
    def safe_to_dec(item)
      item = Date.new(item.year, item.month, item.day) if date_like?(item)
      item = item.jd if item.respond_to?(:jd)
      
      item.to_d
    rescue
      0.0
    end
    
    def date_like?(item)
      return false if item.respond_to?(:jd)
      
      %i[year month day].all? do |method| 
        item.respond_to?(method) &&
          item.send(method).class.eql?(Integer) 
      end
    end
    
    def date_label(val)
      val = Date.jd(val) if val.class.superclass.eql?(Numeric)

      val.respond_to?(:strftime) ? val.strftime('%F') : val.to_s
    end
    
    def grid_index(width, x, y)
      width * y + x
    end
    
    def scaled_position(n, a, b, scale_length)
      multiplier = scale_length.to_d / (b - a)
      
      (n - a) * multiplier
    end
    
    def scale(min, max)
      return [0, 1, 1] unless valid_max_min?(min, max)
      
      step = scale_interval(min, max)
      
      a = scale_a(min, step)
      b = scale_b(max, step)
      
      [a, b, step]
    end
    
    def scale_a(min, step)
      return 0 if min.zero? 
      
      unscaled_a = (min.to_d / step).to_i
      unscaled_a -= 1 if min.negative? || (min == unscaled_a * step)
      
      unscaled_a * step
    end
    
    def scale_b(max, step)
      return 0 if max.zero? 
      
      unscaled_b = (max.to_d / step).to_i
      unscaled_b += 1 if max.positive? || (max == unscaled_b * step)
      
      unscaled_b * step
    end
    
    def scale_interval(min, max)
      diff = (max - min).abs
      
      case diff
      when 0..2
        0.5
      when 3..10
        1
      else
        10**Math.log(diff, 10).to_i
      end
    end
    
    def valid_max_min?(min, max)
      [min, max].all? { |n| n.class.superclass.eql?(Numeric) } && max > min
    end
    
    def valid_collection?(item)
      item.respond_to?(:first) && item.first.class.superclass.eql?(ApplicationRecord)
    end
    
    module_function :max_values, :array_of_arrays?, :initialize_maxes, :multiplier, :safe_to_dec, :date_like?,
                    :date_label, :grid_index, :scaled_position, :scale, :scale_a, :scale_b, :scale_interval, 
                    :valid_max_min?, :valid_collection?
  end
  
  private_constant :Util
end
