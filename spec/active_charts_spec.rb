require 'spec_helper'
require 'active_support/inflector'

RSpec.describe ActiveCharts do
  include ActiveSupport::Inflector
  
  let(:helpers) { %w[BarChartHelper ScatterPlotHelper CollectionParser] }
  
  it 'has a version number' do
    expect(ActiveCharts::VERSION).to eq('0.1.5.2')
  end
  
  it 'has helper modules and classes' do
    helpers.each do |helper|
      helper = "ActiveCharts::Helpers::#{helper}"
      expect(Object.const_get(helper)).to be(constantize(helper))
    end
  end
end
