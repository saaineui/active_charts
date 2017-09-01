module ActiveCharts
  RSpec.describe Chart do
    it "#colors" do
      expect(Chart.new.colors).to eql([])
    end
  end
end
