require 'spec_helper'
require 'factories/pets'
require 'mocks/svg_chart'

module ActiveCharts
  module Helpers 
    RSpec.describe 'BarChartHelper' do
      include BarChartHelper
      
      let(:empty_pets) { Factories::Pets.empty }
      let(:options) { Factories::Pets.options(1) }
      let(:columns) { Factories::Pets.columns }
      let(:spare_options) { Factories::Pets.options }
      let(:pets_title) { %(<figcaption class="ac-chart-title">Pets per Floor</figcaption>) }
      let(:collection) { Factories::Pets.collection }
      let(:pets) { Factories::Pets.all }
      let(:mock_bar_chart) { SVGChart.bar_chart }
      let(:bar_chart_empty) { SVGChart.bar_chart_empty }
      
      it 'has CollectionParser class' do
        expect { CollectionParser.new(pets, columns, nil) }.not_to raise_error      
      end

      it 'has Util module functions' do
        expect { Util.safe_to_dec(0) }.not_to raise_error
      end
      
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
          expect(bar_chart_for(pets, columns, spare_options)).to eq(mock_bar_chart)
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
