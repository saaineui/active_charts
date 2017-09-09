# Mock ApplicationRecord for testing _chart_for helpers
class ApplicationRecord
end

class Pet < ApplicationRecord
  def initialize(name = nil, floor_1 = nil, floor_2 = nil)
    @name = name
    @floor_1 = floor_1
    @floor_2 = floor_2
  end

  attr_reader :name, :floor_1, :floor_2

  def attribute_names
    %w[name floor_1 floor_2]
  end
  
  def self.pluck(*columns)
    case columns
    when %i[name]
      ['cats', 'dogs']
    when %i[floor_1 floor_2]
      [[5, 1], [2, 3]]
    end
  end
end
