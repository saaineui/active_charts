require 'spec_helper'
require 'mocks/pet'
require 'mocks/pet_collection'
require 'mocks/svg_chart'

module ActiveCharts
  module Helpers 
    RSpec.describe 'BarChartHelper' do
      include BarChartHelper
      
      let(:empty_pets) { PetCollection.new([]) }
      let(:options) { { title: 'Pets per Floor', rows: %w[cats dogs], series_labels: ['Floor 1', 'Floor 2'], height: 410 } }
      let(:spare_options) { { title: options[:title], height: options[:height] } }
      let(:pets_title) { %(<figcaption class="ac-chart-title">Pets per Floor</figcaption>) }
      let(:collection) { [[5, 1], [2, 3]] }
      let(:pets) { PetCollection.new(Pet.new('cats', 5, 1), Pet.new('dogs', 2, 3)) }
      let(:mock_bar_chart) { SVGChart.bar_chart }
      let(:bar_chart_empty) { SVGChart.bar_chart_empty }

      describe '::bar_chart' do
        it 'returns a <figure>, <figcaption>, <svg> chart and <ul> legend' do
          expect(bar_chart(collection, options)).to eq(mock_bar_chart)
        end
        
        it 'handles empty array' do
          expect(bar_chart([])).to eq(bar_chart_empty)
          expect(bar_chart([[]])).to eq(bar_chart_empty)
        end
        
        it 'handles non-array' do
          expect(bar_chart(1)).to eq(bar_chart_empty)
        end
      end
        
      describe '::bar_chart_for' do
        it 'returns a <figure>, <figcaption>, <svg> chart and <ul> legend' do
          expect(bar_chart_for(pets, %i[floor_1 floor_2], spare_options)).to eq(mock_bar_chart)
          expect(bar_chart_for(pets)).to_not be(nil)
        end
        
        it 'handles empty collection' do
          expect(bar_chart_for(empty_pets)).to eq(bar_chart_empty)
          expect(bar_chart_for(empty_pets, [], options)).to include(pets_title)
        end
        
        it 'handles non-collection' do
          expect(bar_chart_for(1)).to eq(bar_chart_empty)
          expect(bar_chart_for(1, [], options)).to include(pets_title)
        end
      end
    end
  end
end
