require 'spec_helper'

RSpec.describe ActiveCharts do
  it 'has a version number' do
    expect(ActiveCharts::VERSION).to eq('0.1.2')
    expect(Object.const_get('ActiveCharts::Helpers::ChartHelper')).to be(ActiveCharts::Helpers::ChartHelper)
  end
end
