require 'spec_helper'
require 'mocks/svg_chart'

module ActiveCharts
  RSpec.describe RectangularChart do
    let(:collection) { [[5, 1], [2, 3, '0.1']] }
    let(:options) { { title: 'Pets per Floor', columns: ['<b>Floor 1</b>', 'Floor 2'], rows: ['cats', 'dogs'], width: 500, height: 500, label_height: 20, class: 'my-class', data_formatters: %i[delimiter percent rounded] } }
    let(:chart_stub) { RectangularChart.new(collection, {}) }
    let(:chart) { RectangularChart.new(collection, options) }
    let(:rect_tag) { SVGChart.grid_rect_tag(options[:height], options[:width]) }
    
    it '#title returns title from options or empty string' do
      expect(chart_stub.title).to eql('')
      expect(chart.title).to eql(options[:title])
    end
    
    it '#collection returns collection' do
      expect(chart_stub.collection).to eql(collection)
    end
    
    it '#svg_height returns options value or 400' do
      expect(chart.svg_height).to eql(500)
      expect(chart_stub.svg_height).to eql(400)
    end
    
    it '#svg_width returns options value or 600' do
      expect(chart.svg_width).to eql(500)
      expect(chart_stub.svg_width).to eql(600)
    end

    it '#grid_height returns options value or 400' do
      expect(chart.grid_height).to eql(500)
      expect(chart_stub.grid_height).to eql(400)
    end
    
    it '#grid_width returns options value or 600' do
      expect(chart.grid_width).to eql(500)
      expect(chart_stub.grid_width).to eql(600)
    end
    
    it '#grid_rect_tag' do
      expect(chart.grid_rect_tag).to eql(rect_tag)
    end
    
    it '#chart_svg_tag returns <svg> chart' do
      expect(chart.chart_svg_tag).to be(nil)
    end
  end
end
