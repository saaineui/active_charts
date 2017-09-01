require "spec_helper"

RSpec.describe ActiveCharts do
  it "has a version number" do
    expect(ActiveCharts::VERSION).not_to be nil
  end

  it "::setup returns true" do
    expect(ActiveCharts.setup).to eq(true)
  end
end
