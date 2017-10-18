require 'spec_helper'
require 'mocks/svg_chart'

module ActiveCharts
  RSpec.describe LineChart do
    let(:collection) { [[[5, 1], [-3, -2]], [[2, '0.1'], [1, -8]]] }
    let(:options) { { title: 'YoY Sales Growth vs. YoY Marketing Spend', series_labels: %w[Lemonade Cookies], rows: %w[Q1 Q2], width: 700, height: 500, label_height: 20, data_formatters: %i[currency default] } }
    let(:line_chart_stub) { LineChart.new(collection, {}) }
    let(:line_chart) { LineChart.new(collection, options) }
    let(:rect_tag) { SVGChart.grid_rect_tag(line_chart.grid_height, line_chart.grid_width) }
    
    it '#title returns title from options or empty string' do
      expect(line_chart_stub.title).to eql('')
      expect(line_chart.title).to eql(options[:title])
    end
    
    it '#collection returns collection' do
      expect(line_chart_stub.collection).to eql([[[5.0, 1.0], [-3.0, -2.0]], [[2.0, 0.1], [1.0, -8.0]]])
    end
    
    it '#x_labels returns enumerator of ticks' do
      x_labels = line_chart_stub.x_labels
      expect(x_labels.class).to eql(Enumerator)
      expect(x_labels.to_a).to eql((-4..6).to_a)
    end
    
    it '#y_labels returns enumerator of ticks' do
      y_labels = line_chart_stub.y_labels
      expect(y_labels.class).to eql(Enumerator)
      expect(y_labels.to_a).to eql((-9..2).to_a)
    end
    
    it '#series_labels returns array of column labels, if any' do
      expect(line_chart_stub.series_labels).to eql([])
      expect(line_chart.series_labels).to eql(options[:series_labels])
    end
    
    it '#columns_count returns number of columns in collection' do
      expect(line_chart.columns_count).to eql(2)
    end
    
    it '#rows_count returns number of rows in collection' do
      expect(line_chart.rows_count).to eql(2)
    end
    
    it '#grid_rect_tag' do
      expect(line_chart.grid_rect_tag).to eql(rect_tag)
    end
    
    it '#chart_svg_tag returns <svg> chart' do
      chart_svg_tag = line_chart.chart_svg_tag
      
      expect(chart_svg_tag).to include(%(<svg xmlns="http://www.w3.org/2000/svg" style="width: 700px; height: auto;" viewBox="0 0 700 500" class="ac-chart ac-line-chart">))
      expect(chart_svg_tag).to include(rect_tag)
      expect(chart_svg_tag).to include(%(</svg>))
    end

    it '#legend_list_tag returns <ul> and <li> legend' do
      expect(line_chart.legend_list_tag).to eq(%(<ul class="ac-chart ac-series-legend"><li class="series-a">Lemonade</li><li class="series-b">Cookies</li></ul>))
    end

    it '#dots_specs' do
      expect(line_chart.dots_specs.first).to eq(
        [
          { cx: 558.0, cy: 41.818182, label: 'Q1' }, 
          { cx: 372.0, cy: 79.454545, label: 'Q2' }
        ]
      )
    end
    
    it '#lines returns array of <path> tags' do
      lines = line_chart.lines
      expect(lines.count).to eq(2)
      
      lines.each do |line|
        expect(line).to include(%(<path))
      end
    end
    
    it '#line_labels returns array of <text> tags' do
      line_chart.line_label_tags.each do |line_label_tag|
        expect(line_label_tag).to include(%(<text))
      end
    end
    
    it '#bottom_label_text_tags' do
      expect(line_chart.bottom_label_text_tags).to include(SVGChart.xy_chart_x_labels)
    end
  end
end
