module ActiveCharts
  RSpec.describe Chart do
    let(:collection) { [3, 0, 5] }
    let(:options) { { title: 'Cats per Floor', class: 'my-class' } }
    
    it '#title returns title from options or empty string' do
      expect(Chart.new(collection, {}).title).to eql('')
      expect(Chart.new(collection, options).title).to eql(options[:title])
    end
    
    it '#extra_css_classes returns class from options or empty string' do
      expect(Chart.new(collection, {}).extra_css_classes).to eql('')
      expect(Chart.new(collection, options).extra_css_classes).to eql(options[:class])
    end
    
    it '#collection returns collection' do
      expect(Chart.new(collection, {}).collection).to eql(collection)
    end
  end
end
