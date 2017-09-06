module ActiveCharts
  RSpec.describe Util do
    it '::multiplier returns float for pixels:data_value ratio' do
      expect(Util.multiplier(11, 200, 6)).to eql(18.181818)
      expect(Util.multiplier(100, 16, 6)).to eql(0.16)
    end
    
    it '::safe_to_dec attempts to_d and returns 0.0 if failed' do
      expect(Util.safe_to_dec('100.01')).to eql(100.01)
      expect(Util.safe_to_dec('String')).to eql(0.0)
    end
  end
end
