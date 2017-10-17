require 'spec_helper'
require 'mocks/pet'
require 'mocks/pet_collection'

module ActiveCharts
  module Helpers 
    RSpec.describe 'CollectionParser' do
      let(:pets) { PetCollection.new(Pet.new('cats', 1, 2)) }
      let(:cp) { CollectionParser.new(pets, [:floor_1, :floor_2, :random], nil) }
      
      it '#collection' do
        expect(cp.collection).to eq([[1, 2]])
      end
      
      it '#columns' do
        expect(cp.columns).to eq([:floor_1, :floor_2])
      end
      
      it '#rows' do
        expect(cp.rows).to eq(['cats'])
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
