# Mock ApplicationRecord for testing _chart_for helpers
class ApplicationRecord
end

class Pet < ApplicationRecord
  def initialize(name = nil, *floors)
    @name = name
    @floor_1 = floors[0]
    @floor_2 = floors[1]
    @floor_3 = floors[2]
    @floor_4 = floors[3]
  end

  attr_reader :name, :floor_1, :floor_2, :floor_3, :floor_4

  def attribute_names
    %w[name floor_1 floor_2 floor_3 floor_4]
  end
end

class Cat < Pet
  def attribute_names
    %w[floor_1 floor_2 floor_3 floor_4]
  end
end  
