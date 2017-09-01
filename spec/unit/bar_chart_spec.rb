module ActiveCharts
  RSpec.describe BarChart do
    it "#x_labels" do
      expect(BarChart.new.x_labels).to eql([])
    end
  end
end
