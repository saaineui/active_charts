require 'spec_helper'

module ActiveCharts
  RSpec.describe Chart do
    let(:collection) { [[3, 1], [3.55, 'zero', 5], ['3.6', -2, 5.0]] }
    let(:options) { { title: 'Cats per Floor', class: 'my-class', max_values: [5, 6, 5], label_height: 20, data_formatters: %i[delimiter percent rounded] } }
    let(:chart_stub) { Chart.new(collection, {}) }
    let(:chart_no_data) { Chart.new('collection', {}) }
    let(:chart) { Chart.new(collection, options) }
    let(:computed_max_values) { [3.6, 1.0, 5.0] }
    
    it '#title returns title from options or empty string' do
      expect(chart_stub.title).to eql('')
      expect(chart.title).to eql(options[:title])
    end
    
    it '#series_class returns a valid series css class name' do
      expect(chart_stub.send(:series_class, 1)).to eql('series-b')
      expect(chart_stub.send(:series_class, 18)).to eql('series-d')
    end
    
    it '#extra_css_classes returns class from options or empty string' do
      expect(chart_stub.extra_css_classes).to eql('')
      expect(chart.extra_css_classes).to eql(options[:class])
    end
    
    it '#collection returns collection or empty array of arrays' do
      expect(chart_stub.collection).to eql(collection)
      expect(chart_no_data.collection).to eql([[]])
    end
    
    it '#max_values returns array of max values per column' do
      expect(chart_stub.max_values).to eql(computed_max_values)
    end
    
    it '#max_values returns computed max values w/o mutating collection' do
      chart_collection = chart_stub.collection
      chart_stub.max_values
      expect(chart_collection).to eql(chart_stub.collection)
    end
    
    it '#max_values returns array from options if set' do
      expect(chart.max_values).to eql([5, 6, 5])
    end
    
    it '#max_values falls back on computed if options array is ivalid' do
      expect(Chart.new(collection, max_values: [6]).max_values).to eql(computed_max_values)
    end
    
    it '#max_values falls back on computed if options array is ivalid' do
      expect(Chart.new(collection, single_y_scale: true).max_values).to eql([5.0, 5.0, 5.0])
    end
    
    it '#to_html returns <figure> container and <figcaption> title' do
      expect(chart.to_html).to eql(%(<figure class="ac-chart-container ac-clearfix my-class"><figcaption class="ac-chart-title">Cats per Floor</figcaption>
          
          <ul class="ac-chart ac-series-legend"></ul></figure>))
    end
    
    it '#label_height returns options value or 10' do
      expect(chart.label_height).to eql(20)
      expect(chart_stub.label_height).to eql(10)
    end
    
    it '#data_formatters returns array of formatter types of size column_count' do
      expect(chart.data_formatters).to eql(%i[delimiter percent rounded])
      expect(chart_stub.data_formatters).to eql([])
    end
    
    it '#formatted_val returns value formatted by specified type' do
      expect(chart.send(:formatted_val, 25_125, :currency)).to eq('$25,125')
      expect(chart.send(:formatted_val, 0.12345, :percent)).to eq('12.3%')
      expect(chart.send(:formatted_val, Date.new(2017, 1, 1), :date)).to eq('2017-01-01')
      expect(chart.send(:formatted_val, 2_457_756.0, :date)).to eq('2017-01-02')
    end
  end
end
