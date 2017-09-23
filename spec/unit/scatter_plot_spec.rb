require 'spec_helper'
require 'mocks/svg_chart'

module ActiveCharts
  RSpec.describe ScatterPlot do
    let(:collection) { [[[5, 1], [-3, -2]], [[2, '0.1'], [1, -8]]] }
    let(:options) { { title: 'YoY Sales Growth vs. YoY Marketing Spend', columns: ['Lemonade', 'Cookies'], rows: ['Q1', 'Q2'], width: 700, height: 500, label_height: 20, class: 'my-class' } }
    let(:scatter_stub) { ScatterPlot.new(collection, {}) }
    let(:scatter) { ScatterPlot.new(collection, options) }
    let(:rect_tag) { SVGChart.grid_rect_tag(scatter.grid_height, scatter.grid_width) }
    
    it '#title returns title from options or empty string' do
      expect(scatter_stub.title).to eql('')
      expect(scatter.title).to eql(options[:title])
    end
    
    it '#collection returns collection' do
      expect(scatter_stub.collection).to eql([[[5.0, 1.0], [-3.0, -2.0]], [[2.0, 0.1], [1.0, -8.0]]])
    end
    
    it '#x_labels returns enumerator of ticks' do
      x_labels = scatter_stub.x_labels
      expect(x_labels.class).to eql(Enumerator)
      expect(x_labels.to_a).to eql((-4..6).to_a)
    end
    
    it '#y_labels returns enumerator of ticks' do
      y_labels = scatter_stub.y_labels
      expect(y_labels.class).to eql(Enumerator)
      expect(y_labels.to_a).to eql((-9..2).to_a)
    end
    
    it '#series_labels returns array of column labels, if any' do
      expect(scatter_stub.series_labels).to eql([])
      expect(scatter.series_labels).to eql(options[:columns])
    end
    
    it '#svg_height returns default or options height' do
      expect(scatter.svg_height).to eql(500)
      expect(scatter_stub.svg_height).to eql(400)
    end
    
    it '#columns_count returns number of columns in collection' do
      expect(scatter.columns_count).to eql(2)
    end
    
    it '#rows_count returns number of rows in collection' do
      expect(scatter.rows_count).to eql(2)
    end
    
    it '#svg_width returns default or options width' do
      expect(scatter.svg_width).to eql(700)
      expect(scatter_stub.svg_width).to eql(600)
    end

    it '#grid_height returns svg_height offset by label_height' do
      expect(scatter.grid_height).to eql(460)
    end
    
    it '#grid_rect_tag' do
      expect(scatter.grid_rect_tag).to eql(rect_tag)
    end
    
    it '#chart_svg_tag returns <svg> chart' do
      chart_svg_tag = scatter.chart_svg_tag
      
      expect(chart_svg_tag).to include(%(<svg xmlns="http://www.w3.org/2000/svg" style="width: 700px; height: auto;" viewBox="0 0 700 500" class="ac-chart ac-scatter-plot">))
      expect(chart_svg_tag).to include(rect_tag)
      expect(chart_svg_tag).to include(%(</svg>))
    end

    it '#legend_list_tag returns <ul> and <li> legend' do
      expect(scatter.legend_list_tag).to eq(%(<ul class="ac-chart ac-series-legend"><li class="series-a">Lemonade</li><li class="series-b">Cookies</li></ul>))
    end

    it '#dots_specs' do
      expect(scatter.dots_specs.first).to eq([
        { cx: 594.0, cy: 41.818182, class: "ac-scatter-plot-dot series-a", label: 'Q1' }, 
        { cx: 66.0, cy: 167.272727, class: "ac-scatter-plot-dot series-b", label: 'Q1' }])
    end
    
    it '#dots returns array of <circle> and <text> tags' do
      dots = scatter.dots
      expect(dots.count).to eq(4)
      
      dots.each do |dot|
        expect(dot.first).to include(%(<circle))
        expect(dot.last).to include(%(<text))
      end
    end
    
    it '#bottom_label_text_tags' do
      expect(scatter.bottom_label_text_tags).to include(%(<text x="0.0" y="490.0">-4</text><text x="66.0" y="490.0">-3</text><text x="132.0" y="490.0">-2</text>))
    end
  end
end
