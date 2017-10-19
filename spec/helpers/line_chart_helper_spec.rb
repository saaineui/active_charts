require 'spec_helper'
require 'mocks/pet'
require 'mocks/pet_collection'
require 'mocks/svg_chart'

module ActiveCharts
  module Helpers 
    RSpec.describe 'LineChartHelper' do
      include LineChartHelper
      
      let(:xy_collection) { [[[5, 1], [5, 0]], [[2, 3], [2, 0]]] }
      let(:xy_pets) { PetCollection.new(Pet.new('cats', 5, 1, 0), Pet.new('dogs', 2, 3)) }
      let(:xy_options) { { title: 'Pets per Floor', rows: %w[cats dogs], series_labels: ['Floor 1 vs. Floor 2', 'Floor 1 vs. Floor 3'] } }
      let(:empty_pets) { PetCollection.new([]) }
      let(:spare_options) { { title: xy_options[:title], height: xy_options[:height] } }
      let(:pets_title) { %(<figcaption class="ac-chart-title">Pets per Floor</figcaption>) }
      let(:mock_line_chart) { SVGChart.line_chart }
      let(:line_chart_empty) { SVGChart.xy_chart_empty(600, 400, 'line-chart') }
      
      describe '::line_chart' do
        it 'returns a <figure>, <figcaption>, <svg> chart and <ul> legend' do
          expect(line_chart(xy_collection, xy_options)).to eq(mock_line_chart)
        end
        
        it 'handles empty array' do
          expect(line_chart([])).to eq(line_chart_empty)
          expect(line_chart([[]])).to eq(line_chart_empty)
        end
        
        it 'handles non-array' do
          expect(line_chart(1)).to eq(line_chart_empty)
        end
      end
        
      describe '::line_chart_for' do
        it 'returns a <figure>, <figcaption>, <svg> chart and <ul> legend' do
          expect(line_chart_for(xy_pets, %i[floor_1 floor_2 floor_3], spare_options)).to eq(mock_line_chart)
          expect(line_chart_for(xy_pets)).to_not be(nil)
        end
        
        it 'handles empty collection' do
          expect(line_chart_for(empty_pets)).to_not be(nil)
          expect(line_chart_for(empty_pets, [], xy_options)).to include(pets_title)
        end
        
        it 'handles non-collection' do
          expect(line_chart_for(1)).to_not be(nil)
          expect(line_chart_for(1, [], xy_options)).to include(pets_title)
        end
      end
    end
  end
end
