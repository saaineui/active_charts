require 'spec_helper'
require 'factories/pets'

module ActiveCharts
  module Helpers 
    RSpec.describe 'CollectionParser' do
      let(:cp) { CollectionParser.new(Factories::Pets.all, %i[floor_1 floor_2 random], nil) }
      let(:floor_columns) { Factories::Pets.columns }
      let(:collection) { Factories::Pets.collection }
      
      it '#collection' do
        expect(cp.collection).to eq(collection)
      end
      
      it '#columns' do
        expect(cp.columns).to eq(floor_columns)
      end
      
      it '#rows' do
        expect(cp.rows).to eq(Factories::Pets.rows)
        
        # if label_column is not given or is not whitelisted, first column is used automatically
        cat = Cat.new('cats', 1, 2)
        pets_auto = PetCollection.new(cat)
        expect(CollectionParser.new(pets_auto, floor_columns, nil).rows).to eq([1])
      end

      it '#xy_collection' do
        expect(cp.xy_collection).to eq(collection.map { |xy| [xy] })
      end
      
      it '#series_labels' do
        expect(cp.series_labels).to eql(Factories::Pets.series_labels)
      end

      it '#xy_series_labels' do
        expect(cp.xy_series_labels).to eql(Factories::Pets.series_labels(:large)[0, 1])
      end
    end
  end
end
