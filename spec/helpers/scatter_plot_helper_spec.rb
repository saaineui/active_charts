require 'spec_helper'
require 'factories/pets'
require 'mocks/svg_chart'

module ActiveCharts
  module Helpers 
    RSpec.describe 'ScatterPlotHelper' do
      include ScatterPlotHelper
      
      let(:xy_collection) { Factories::Pets.collection(:large) }
      let(:xy_pets) { Factories::Pets.all(:large) }
      let(:xy_options) { Factories::Pets.options(2) }
      let(:empty_pets) { Factories::Pets.empty }
      let(:spare_options) { Factories::Pets.options }
      let(:pets_title) { %(<figcaption class="ac-chart-title">Pets per Floor</figcaption>) }
      let(:mock_scatter_plot) { SVGChart.scatter_plot }
      let(:scatter_plot_empty) { SVGChart.xy_chart_empty }
      
      describe '::scatter_plot' do
        it 'returns a <figure>, <figcaption>, <svg> chart and <ul> legend' do
          expect(scatter_plot(xy_collection, xy_options)).to eq(mock_scatter_plot)
        end
        
        it 'handles empty array' do
          expect(scatter_plot([])).to eq(scatter_plot_empty)
          expect(scatter_plot([[]])).to eq(scatter_plot_empty)
        end
        
        it 'handles non-array' do
          expect(scatter_plot(1)).to eq(scatter_plot_empty)
        end
      end
        
      describe '::scatter_plot_for' do
        it 'returns a <figure>, <figcaption>, <svg> chart and <ul> legend' do
          expect(scatter_plot_for(xy_pets, %i[floor_1 floor_2 floor_3], spare_options)).to eq(mock_scatter_plot)
          expect(scatter_plot_for(xy_pets)).to_not be(nil)
        end
        
        it 'handles empty collection' do
          expect(scatter_plot_for(empty_pets)).to_not be(nil)
          expect(scatter_plot_for(empty_pets, [], xy_options)).to include(pets_title)
        end
        
        it 'handles non-collection' do
          expect(scatter_plot_for(1)).to_not be(nil)
          expect(scatter_plot_for(1, [], xy_options)).to include(pets_title)
        end
      end
    end
  end
end
