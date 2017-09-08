module ActiveCharts
  # @private
  module Util
    def max_values(array_of_arrays)
      return [] unless array_of_arrays?(array_of_arrays)
      
      maxes = array_of_arrays.first.map { |cell| safe_to_dec(cell) }
      
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
    
    def valid_columns(resource, columns)
      attribute_names = resource.new.attribute_names.map(&:to_sym) 
      
      return attribute_names if columns.eql?([])
      
      attribute_names & columns
    end
    
    def label_column(resource)
      attribute_names = resource.new.attribute_names
      
      %w[name title id].each do |attribute_name|
        return attribute_name.to_sym if attribute_names.include?(attribute_name)
      end
      
      attribute_names.first.to_sym
    end
    
    module_function :max_values, :array_of_arrays?, :multiplier, :safe_to_dec, :grid_index, 
                    :valid_columns, :label_column
  end
end
