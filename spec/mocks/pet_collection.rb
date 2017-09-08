# Mock Resource Collection for testing _chart_for helpers
class PetCollection
  def all
    [Pet.new('cats', 5, 1), Pet.new('dogs', 2, 3)]
  end
  
  def first
    all.first
  end
  
  def pluck(*columns)
    all.map do |pet|
      if columns.size.eql?(1)
        pet.send(columns.first)
      else
        columns.map { |col| pet.send(col) }
      end
    end
  end
end
