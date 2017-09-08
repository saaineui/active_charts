# Mock ApplicationRecord for testing _chart_for helpers
class Pet
  def initialize(name = nil, floor_1 = nil, floor_2 = nil)
    @name = name
    @floor_1 = floor_1
    @floor_2 = floor_2
  end

  attr_reader :name, :floor_1, :floor_2

  def attribute_names
    %w[name floor_1 floor_2]
  end
end
