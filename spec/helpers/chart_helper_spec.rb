require 'spec_helper'
require 'mocks/pet'
require 'mocks/pet_collection'

module ActiveCharts
  module Helpers 
    RSpec.describe 'ChartHelper' do
      include ChartHelper

      let(:collection) { [[5, 1], [2, 3]] }
      let(:pets) { PetCollection.new(Pet.new('cats', 5, 1), Pet.new('dogs', 2, 3)) }
      let(:empty_pets) { PetCollection.new([]) }
      
      let(:options) { { title: 'Pets per Floor', rows: ['cats', 'dogs'], columns: ['Floor 1', 'Floor 2'], height: 410 } }
      let(:spare_options) { { title: options[:title], height: options[:height] } }
      
      let(:chart) { %(<figure class="ac-chart-container ac-clearfix "><figcaption class="ac-chart-title">Pets per Floor</figcaption>
          <svg xmlns="http://www.w3.org/2000/svg" style="width: 280px; height: auto;" viewBox="0 0 280 410" class="ac-chart ac-bar-chart"><rect height="390" width="280" class="grid" />
          <rect height="360.0" x="20" y="30.0" class="ac-bar-chart-bar series-a" width="40" />
          <text x="40" y="25.0">5</text>
          <rect height="120.0" x="80" y="270.0" class="ac-bar-chart-bar series-b" width="40" />
          <text x="100" y="265.0">1</text>
          <rect height="144.0" x="160" y="246.0" class="ac-bar-chart-bar series-a" width="40" />
          <text x="180" y="241.0">2</text>
          <rect height="360.0" x="220" y="30.0" class="ac-bar-chart-bar series-b" width="40" />
          <text x="240" y="25.0">3</text>
          <text x="70.0" y="405.0">cats</text><text x="210.0" y="405.0">dogs</text></svg>
          <ul class="ac-chart ac-series-legend"><li class="series-a">Floor 1</li><li class="series-b">Floor 2</li></ul></figure>) }
      let(:empty_chart) { %(<figure class="ac-chart-container ac-clearfix "><figcaption class="ac-chart-title"></figcaption>
          <svg xmlns="http://www.w3.org/2000/svg" style="width: 20px; height: auto;" viewBox="0 0 20 400" class="ac-chart ac-bar-chart"><rect height="380" width="20" class="grid" />
          </svg>
          <ul class="ac-chart ac-series-legend"></ul></figure>) }
      
      describe '::bar_chart' do
        it 'returns a <figure>, <figcaption>, <svg> chart and <ul> legend' do
          expect(bar_chart(collection, options)).to eq(chart)
        end
        
        it 'handles empty array' do
          expect(bar_chart([])).to eq(empty_chart)
          expect(bar_chart([[]])).to eq(empty_chart)
        end
        
        it 'handles non-array' do
          expect(bar_chart(1)).to eq(empty_chart)
        end
      end
        
      describe '::bar_chart_for' do
        it 'returns a <figure>, <figcaption>, <svg> chart and <ul> legend' do
          expect(bar_chart_for(pets, [:floor_1, :floor_2], spare_options)).to eq(chart)
          expect(bar_chart_for(pets)).to_not be(nil)
        end
        
        it 'handles empty collection' do
          expect(bar_chart_for(empty_pets)).to eq(empty_chart)
          expect(bar_chart_for(empty_pets, [], options)).to include(%(<figcaption class="ac-chart-title">Pets per Floor</figcaption>))
        end
        
        it 'handles non-collection' do
          expect(bar_chart(1)).to eq(empty_chart)
          expect(bar_chart_for(1, [], options)).to include(%(<figcaption class="ac-chart-title">Pets per Floor</figcaption>))
        end
      end
    end
  end
end
