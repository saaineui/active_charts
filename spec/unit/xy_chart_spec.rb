require 'spec_helper'
require 'mocks/svg_chart'

module ActiveCharts
  RSpec.describe XYChart do
    let(:collection) { [[[5, 1], [-3, -2]], [[2, '0.1'], [1, -8]]] }
    let(:date_collection) { [[[Date.new(2016, 1, 1), 1]], [[Date.new(2017, 1, 1), 2]]] }
    let(:options) { { title: 'YoY Sales Growth vs. YoY Marketing Spend', series_labels: %w[Lemonade Cookies], rows: %w[Q1 Q2], width: 700, height: 500, label_height: 20, class: 'my-class', data_formatters: %i[currency default] } }
    let(:chart_stub) { XYChart.new(collection, {}) }
    let(:chart) { XYChart.new(collection, options) }
    let(:date_chart) { XYChart.new(date_collection, data_formatters: [:date]) }
    let(:rect_tag) { SVGChart.grid_rect_tag(chart.grid_height, chart.grid_width) }
    
    it '#title returns title from options or empty string' do
      expect(chart_stub.title).to eql('')
      expect(chart.title).to eql(options[:title])
    end
    
    it '#collection returns collection' do
      normalized_collection = [[[5.0, 1.0], [-3.0, -2.0]], [[2.0, 0.1], [1.0, -8.0]]]
      
      expect(chart_stub.collection).to eql(normalized_collection)
      expect(chart.collection).to eql(normalized_collection)
    end
    
    it '#x_min returns x-axis start value' do
      expect(chart_stub.x_min).to eql(-4)
      expect(chart.x_min).to eql(-4)
    end
    
    it '#x_max returns' do
      expect(chart_stub.x_max).to eql(6)
      expect(chart.x_max).to eql(6)
    end
    
    it '#y_min returns' do
      expect(chart_stub.y_min).to eql(-9)
      expect(chart.y_min).to eql(-9)
    end
    
    it '#y_max returns' do
      expect(chart_stub.y_max).to eql(2)
      expect(chart.y_max).to eql(2)
    end
    
    it '#x_labels returns enumerator of ticks' do
      x_labels = chart_stub.x_labels
      expect(x_labels.class).to eql(Enumerator)
      expect(x_labels.to_a).to eql((-4..6).to_a)
      
      expect(date_chart.x_labels.to_a).to eql((2_457_300..2_457_800).step(100).to_a)
    end
    
    it '#y_labels returns enumerator of ticks' do
      y_labels = chart_stub.y_labels
      expect(y_labels.class).to eql(Enumerator)
      expect(y_labels.to_a).to eql((-9..2).to_a)
    end
    
    it '#grid_height returns svg_height offset by label_height * 2' do
      expect(chart_stub.grid_height).to eql(380)
      expect(chart.grid_height).to eql(460)
    end
    
    it '#grid_width returns svg_width offset by MARGIN * 4' do
      expect(chart_stub.grid_width).to eql(520)
      expect(chart.grid_width).to eql(620)
    end
    
    it '#x_label_y returns' do
      expect(chart_stub.x_label_y).to eql(395.0)
      expect(chart.x_label_y).to eql(490.0)
    end
    
    it '#y_label_x returns' do
      expect(chart_stub.y_label_x).to eql(526)
      expect(chart.y_label_x).to eql(626)
    end
    
    it '#section_width returns' do
      expect(chart_stub.section_width).to eql(52.0)
      expect(chart.section_width).to eql(62.0)
    end
    
    it '#section_height returns' do
      expect(chart_stub.section_height).to be_within(0.001).of(380.0 / 11)
      expect(chart.section_height).to be_within(0.001).of(460.0 / 11)
    end
    
    it '#x_ticks returns' do
      x_tick_x = proc { |index| chart_stub.section_width * index }
      
      expect(chart_stub.x_ticks).to eql((1..9).map(&x_tick_x))
    end
    
    it '#y_ticks returns' do
      y_tick_y = proc do |index| 
        (chart_stub.section_height * (11 - index)).round(6) 
      end
        
      expect(chart_stub.y_ticks).to eql((1..10).map(&y_tick_y))
    end
    
    it '#series_labels returns array of column labels, if any' do
      expect(chart_stub.series_labels).to eql([])
      expect(chart.series_labels).to eql(options[:series_labels])
    end
    
    it '#grid_rect_tag' do
      expect(chart.grid_rect_tag).to eql(rect_tag)
    end
    
    it '#legend_list_tag returns <ul> and <li> legend' do
      expect(chart.legend_list_tag).to eq(%(<ul class="ac-chart ac-series-legend"><li class="series-a">Lemonade</li><li class="series-b">Cookies</li></ul>))
    end
    
    it '#side_label_text_tags returns text tags' do
      expect(chart_stub.side_label_text_tags).to include(%(<text x="526" y="380.0" class="ac-y-label">-9</text><text x="526" y="345.454545" class="ac-y-label">-8</text><text x="526" y="310.909091" class="ac-y-label">-7</text>))
    end
    
    it '#bottom_label_text_tags returns text tags' do
      expect(chart.bottom_label_text_tags).to include(SVGChart.xy_chart_x_labels)
      expect(date_chart.bottom_label_text_tags).to include(SVGChart.xy_date_chart_x_labels)
    end
  end
end
