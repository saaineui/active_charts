require 'spec_helper'

module ActiveCharts
  module Helpers 
    RSpec.describe 'ChartHelper' do
      include ChartHelper

      let(:collection) { [['cats', 5, 1], ['dogs', 2, 3]] }
      let(:options) { { title: 'Pets per Floor', columns: ['Floor 1', 'Floor 2'], contains_label: true, height: 410 } }
      
      describe '#bar_chart' do
        it 'returns a <figure>, <figcaption>, <svg> chart' do
          expect(bar_chart(collection, options)).to eq(%(<figure class="ac-chart-container ac-clearfix ">
          <figcaption class="ac-chart-title">Pets per Floor</figcaption>
          <svg xmlns="http://www.w3.org/2000/svg" style="width: 280px; height: 410px;" viewBox="0 0 280 410" class="ac-chart ac-bar-chart">
          <rect height=390 width=280 class="grid" />
          <rect height=360.0 x=20 y=30.0 class="ac-bar-chart-bar series-a" />
          <text x=40 y=20.0>
          5
          </text>
          <rect height=120.0 x=80 y=270.0 class="ac-bar-chart-bar series-b" />
          <text x=100 y=260.0>
          1
          </text>
          <rect height=144.0 x=160 y=246.0 class="ac-bar-chart-bar series-a" />
          <text x=180 y=236.0>
          2
          </text>
          <rect height=360.0 x=220 y=30.0 class="ac-bar-chart-bar series-b" />
          <text x=240 y=20.0>
          3
          </text>
          <text x=70.0 y=405.0>cats</text><text x=210.0 y=405.0>dogs</text>
          </svg>
          </figure>
          <ul class="ac-chart ac-series-legend"><li class="series-a">Floor 1</li><li class="series-b">Floor 2</li></ul>))
        end
      end
    end
  end
end
