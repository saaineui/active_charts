require 'mocks/pet'
require 'mocks/pet_collection'

module Factories
  module Pets
    DEFAULT_OPTIONS = { title: 'Pets per Floor', height: 410 }
    
    module_function
    
    def all(type = nil)
      PetCollection.new(cats(type), dogs)
    end
    
    def empty
      PetCollection.new([])
    end
    
    def cats(type = nil)
      case type
      when :large
        Pet.new('cats', 5, 1, 0)
      else
        Pet.new('cats', 5, 1)
      end
    end
    
    def dogs
      Pet.new('dogs', 2, 3)
    end
    
    def collection(type = nil)
      case type
      when :large
        [[[5, 1], [5, 0]], [[2, 3], [2, 0]]]
      else
        [[5, 1], [2, 3]]
      end
    end
    
    def rows
      %w[cats dogs]
    end
    
    def columns
      %i[floor_1 floor_2]
    end
    
    def series_labels(type = nil)
      case type
      when :large
        ['Floor 1 vs. Floor 2', 'Floor 1 vs. Floor 3']
      else
        ['Floor 1', 'Floor 2']
      end
    end
    
    def options(version = nil)
      case version
      when 1
        DEFAULT_OPTIONS.merge(rows: rows, series_labels: series_labels)
      when 2
        DEFAULT_OPTIONS.merge(rows: rows, series_labels: series_labels(:large))
      when 3
        { title: DEFAULT_OPTIONS[:title], rows: rows, series_labels: series_labels(:large) }
      when 400
        { title: DEFAULT_OPTIONS[:title] }
      else
        DEFAULT_OPTIONS
      end
    end
  end
end
