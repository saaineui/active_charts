require 'spec_helper'
require 'active_support/inflector'
require 'mocks/pet'
require 'mocks/pet_collection'

RSpec.describe ActiveCharts do
  include ActiveSupport::Inflector
  
  let(:helpers) { %w[BarChartHelper ScatterPlotHelper CollectionParser] }
  let(:pets) { Factories::Pets.all }
  let(:columns) { Factories::Pets.columns }
  
  it 'has a version number' do
    expect(ActiveCharts::VERSION).to eq('0.1.6')
  end
  
  it 'helper modules are defined' do
    helpers.each do |helper|
      helper = "ActiveCharts::Helpers::#{helper}"
      expect(Object.const_get(helper)).to be(constantize(helper))
    end
  end
  
  it ':Util is private' do
    expect { ActiveCharts::Util.safe_to_dec(0) }.to raise_error(NameError)
    expect { Util.safe_to_dec(0) }.to raise_error(NameError)
  end
  
  it ':Helpers::CollectionParser is private' do
    expect { ActiveCharts::Helpers::CollectionParser.new(pets, columns, nil) }.to raise_error(NameError)
  end
end
