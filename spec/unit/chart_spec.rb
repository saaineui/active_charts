require 'spec_helper'

module ActiveCharts
  RSpec.describe Chart do
    let(:collection) { [[3, 1], [3.55, 'zero', 5], ['3.6', -2, 5.0]] }
    let(:options) { { title: 'Cats per Floor', class: 'my-class', max_values: [5, 6, 5] } }
    let(:chart_stub) { Chart.new(collection, {}) }
    let(:chart_no_data) { Chart.new('collection', {}) }
    let(:chart) { Chart.new(collection, options) }
    let(:computed_max_values) { [3.6, 1.0, 5.0] }
    
    it '#title returns title from options or empty string' do
      expect(chart_stub.title).to eql('')
      expect(chart.title).to eql(options[:title])
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
      expect(Chart.new(collection, { max_values: [6] }).max_values).to eql(computed_max_values)
    end
    
    it '#max_values falls back on computed if options array is ivalid' do
      expect(Chart.new(collection, { single_y_scale: true }).max_values).to eql([5.0, 5.0, 5.0])
    end
    
    it '#to_html returns <figure> container and <figcaption> title' do
      expect(chart.to_html).to eql(%(<figure class="ac-chart-container ac-clearfix my-class"><figcaption class="ac-chart-title">Cats per Floor</figcaption>
          
          </figure>))
    end
    
    it '#formatted_val returns value formatted by specified type' do
      expect(chart.send(:formatted_val, 0.12345, :percent)).to eq('12.345%')
    end
  end
end
