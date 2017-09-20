require 'spec_helper'

module ActiveCharts
  RSpec.describe BarChart do
    let(:collection) { [[5, 1], [2, 3, '0.1']] }
    let(:options) { { title: 'Pets per Floor', columns: ['<b>Floor 1</b>', 'Floor 2'], rows: ['cats', 'dogs'], bar_width: 50, height: 500, label_height: 20, class: 'my-class', data_formatters: %i[delimiter percent rounded] } }
    let(:bar_chart_stub) { BarChart.new(collection, {}) }
    let(:bar_chart) { BarChart.new(collection, options) }
    let(:rect_tag) { %(<rect height="460" width="460" class="grid" />) }
    
    it '#title returns title from options or empty string' do
      expect(bar_chart_stub.title).to eql('')
      expect(bar_chart.title).to eql(options[:title])
    end
    
    it '#collection returns collection' do
      expect(bar_chart_stub.collection).to eql(collection)
    end
    
    it '#x_labels returns array of row labels, if any' do
      expect(bar_chart_stub.x_labels).to eql([])
      expect(bar_chart.x_labels).to eql(['cats', 'dogs'])
    end
    
    it '#series_labels returns array of column labels, if any' do
      expect(bar_chart_stub.series_labels).to eql([])
      expect(bar_chart.series_labels).to eql(options[:columns])
    end
    
    it '#bar_width returns options value or 40' do
      expect(bar_chart.bar_width).to eql(50)
      expect(bar_chart_stub.bar_width).to eql(40)
    end
    
    it '#svg_height returns options value or 400' do
      expect(bar_chart.svg_height).to eql(500)
      expect(bar_chart_stub.svg_height).to eql(400)
    end
    
    it '#columns_count returns number of columns in collection' do
      expect(bar_chart.columns_count).to eql(3)
    end
    
    it '#rows_count returns number of rows in collection' do
      expect(bar_chart.rows_count).to eql(2)
    end
    
    it '#bars_count returns number of bars in chart' do
      expect(bar_chart.bars_count).to eql(6)
    end
    
    it '#svg_width returns calculated chart width' do
      expect(bar_chart.svg_width).to eql(460)
    end

    it '#grid_height returns svg_height offset by label_height' do
      expect(bar_chart.grid_height).to eql(460)
    end
    
    it '#max_bar_height returns grid_height offset by label_height' do
      expect(bar_chart.max_bar_height).to eql(400)
    end

    it '#grid_rect_tag' do
      expect(bar_chart.grid_rect_tag).to eql(rect_tag)
    end
    
    it '#x_offset' do
      expect(bar_chart.x_offset).to eql(25)
    end
    
    it '#y_offset' do
      expect(bar_chart.y_offset).to eql(10)
    end
    
    it '#section_width' do
      expect(bar_chart.section_width).to eql(230)
    end
    
    it '#y_multipliers' do
      expect(bar_chart.y_multipliers).to eql([80.0, 133.333333, 4000.0])
    end
    
    it '#chart_svg_tag returns <svg> chart' do
      chart_svg_tag = bar_chart.chart_svg_tag
      
      expect(chart_svg_tag).to include(%(<svg xmlns="http://www.w3.org/2000/svg" style="width: 460px; height: auto;" viewBox="0 0 460 500" class="ac-chart ac-bar-chart">))
      expect(chart_svg_tag).to include(rect_tag)
      expect(chart_svg_tag).to include(%(</svg>))
    end

    it '#legend_list_tag returns <ul> and <li> legend' do
      expect(bar_chart.legend_list_tag).to eq(%(<ul class="ac-chart ac-series-legend"><li class="series-a">&lt;b&gt;Floor 1&lt;/b&gt;</li><li class="series-b">Floor 2</li></ul>))
    end

    it '#bars_specs' do
      expect(bar_chart.bars_specs.first).to eq([
        { height: 400.0, x: 20, y: 60.0, class: "ac-bar-chart-bar series-a", val: 5, formatter: :delimiter }, 
        { height: 133.333333, x: 90, y: 326.666667, class: "ac-bar-chart-bar series-b", val: 1, formatter: :percent }])
    end
    
    it '#bars returns array of <rect> and <text> tags' do
      bars = bar_chart.bars
      expect(bars.count).to eq(5)
      
      bars.each do |bar|
        expect(bar.first).to include(%(<rect))
        expect(bar.last).to include(%(<text))
      end
    end
    
    it '#bottom_label_text_tags' do
      expect(bar_chart.bottom_label_text_tags).to eq(%(<text x="115.0" y="490.0">cats</text><text x="345.0" y="490.0">dogs</text>))
    end
  end
end
