module ActiveCharts
  RSpec.describe Util do
    it '::max_values returns array of max values at each index' do
      expect(Util.max_values([[10, -1], [3, 1, 2]])).to eql([10, 1, 2])
    end
    
    it '::multiplier returns float for pixels:data_value ratio' do
      expect(Util.multiplier(11, 200, 6)).to eql(18.181818)
      expect(Util.multiplier(100, 16, 6)).to eql(0.16)
    end
    
    it '::safe_to_dec attempts to_d and returns 0.0 if failed' do
      expect(Util.safe_to_dec('100.01')).to eql(100.01)
      expect(Util.safe_to_dec('String')).to eql(0.0)
    end
    
    it '::grid_index returns item index for 2x2 matrix' do
      expect(Util.grid_index(3, 1, 2)).to eql(7)
      expect(Util.grid_index(3, 0, 1)).to eql(3)
    end
  end
end
