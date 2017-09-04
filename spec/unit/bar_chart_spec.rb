module ActiveCharts
  RSpec.describe BarChart do
    let(:collection) { [['cats', 5, 1], ['dogs', 2, 3]] }
    let(:options) { { title: 'Pets per Floor', columns: ['Floor 1', 'Floor 2'], contains_label: true, bar_width: 50, height: 500, label_height: 20, class: 'my-class' } }
    let(:bar_chart_stub) { BarChart.new(collection, {}) }
    let(:bar_chart) { BarChart.new(collection, options) }
    
    it '#title returns title from options or empty string' do
      expect(bar_chart_stub.title).to eql('')
      expect(bar_chart.title).to eql(options[:title])
    end
    
    it '#series_class returns a valid series css class name' do
      expect(bar_chart.series_class(1)).to eql('series-b')
      expect(bar_chart.series_class(11)).to eql('series-f')
    end
    
    describe '#collection' do
      context 'when contains_label is true' do
        it 'returns collection stripped of first item in each row' do
          expect(bar_chart.collection).to eql([[5, 1], [2, 3]])
        end
      end

      context 'when contains_label is missing' do
        it 'returns collection' do
          expect(bar_chart_stub.collection).to eql(collection)
        end
      end
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
    
    it '#label_height returns options value or 10' do
      expect(bar_chart.label_height).to eql(20)
      expect(bar_chart_stub.label_height).to eql(10)
    end
    
    it '#columns_count returns number of columns in collection' do
      expect(bar_chart.columns_count).to eql(2)
    end
    
    it '#rows_count returns number of rows in collection' do
      expect(bar_chart.rows_count).to eql(2)
    end
    
    it '#bars_count returns number of bars in chart' do
      expect(bar_chart.bars_count).to eql(4)
    end
    
    it '#max_values returns array of max values per column' do
      expect(bar_chart.max_values).to eql([5, 3])
      expect(bar_chart_stub.max_values).to eql([0.0, 5.0, 3.0])
    end
    
    it '#svg_width returns calculated chart width' do
      expect(bar_chart.svg_width).to eql(320)
    end

    it '#grid_height returns svg_height offset by label_height' do
      expect(bar_chart.grid_height).to eql(460)
    end
    
    it '#max_bar_height returns grid_height offset by label_height' do
      expect(bar_chart.max_bar_height).to eql(400)
    end
      
    it '#figure_open_tag returns <figure> and <figcaption>title</figcaption>' do
      expect(bar_chart.figure_open_tag).to eq(%(<figure class="ac-chart-container ac-clearfix my-class">
          <figcaption class="ac-chart-title">Pets per Floor</figcaption>))
    end

    it '#svg_open_tag returns <svg> and grid <rect />' do
      expect(bar_chart.svg_open_tag).to eq(%(<svg xmlns="http://www.w3.org/2000/svg" style="width: 320px; height: 500px;" viewBox="0 0 320 500" class="ac-chart ac-bar-chart">
          <rect height=460 width=320 class="grid" />))
    end

    it '#legend_list_tag returns <ul> and <li> legend' do
      expect(bar_chart.legend_list_tag).to eq(%(<ul class="ac-chart ac-series-legend"><li class="series-a">Floor 1</li><li class="series-b">Floor 2</li></ul>))
    end

    it '#bars_specs' do
      expect(bar_chart.bars_specs.first).to eq([{:height=>400.0, :x=>20, :y=>60.0, :col=>0, :val=>5}, 
                                                {:height=>133.333333, :x=>90, :y=>326.666667, :col=>1, :val=>1}])
    end
    
    it '#bars returns array of <rect> and <text> tags' do
      expect(bar_chart.bars.count).to eq(4)
    end
    
    it '#bottom_label_text_tags' do
      expect(bar_chart.bottom_label_text_tags).to eq(%(<text x=80.0 y=490.0>cats</text><text x=240.0 y=490.0>dogs</text>))
    end
  end
end
