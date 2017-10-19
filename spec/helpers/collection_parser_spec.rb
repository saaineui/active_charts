require 'spec_helper'
require 'mocks/pet'
require 'mocks/pet_collection'

module ActiveCharts
  module Helpers 
    RSpec.describe 'CollectionParser' do
      let(:pet) { Pet.new('cats', 1, 2) }
      let(:pets) { PetCollection.new(pet) }
      let(:cp) { CollectionParser.new(pets, %i[floor_1 floor_2 random], nil) }
      let(:floor_columns) { %i[floor_1 floor_2] }
      
      it '#collection' do
        expect(cp.collection).to eq([[1, 2]])
      end
      
      it '#columns' do
        expect(cp.columns).to eq(floor_columns)
      end
      
      it '#rows' do
        expect(cp.rows).to eq(%w[cats])
        
        # if label_column is not given or is not whitelisted, first column is used automatically
        cat = Cat.new('cats', 1, 2)
        pets_auto = PetCollection.new(cat)
        expect(CollectionParser.new(pets_auto, floor_columns, nil).rows).to eq([1])
      end

      it '#xy_collection' do
        expect(cp.xy_collection).to eq([[[1, 2]]])
      end
      
      it '#series_labels' do
        expect(cp.series_labels).to eql(['Floor 1', 'Floor 2'])
      end

      it '#xy_series_labels' do
        expect(cp.xy_series_labels).to eql(['Floor 1 vs. Floor 2'])
      end
    end
  end
end
