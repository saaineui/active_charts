# Mock Resource Collection for testing _chart_for helpers
class PetCollection
  def initialize(*pets)
    @pets = pets
  end
  
  attr_reader :pets
  
  def all
    pets
  end
  
  def count
    pets.count
  end
  
  def first
    pets.first
  end
  
  def pluck(*columns)
    pets.map do |pet|
      if columns.size.eql?(1)
        pet.send(columns.first)
      else
        columns.map { |col| pet.send(col) }
      end
    end
  end
end
