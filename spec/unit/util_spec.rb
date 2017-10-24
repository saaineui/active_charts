require 'spec_helper'
require 'active_charts/util'
require 'mocks/pet'
require 'mocks/pet_collection'

module ActiveCharts
  RSpec.describe Util do
    let(:pets) { PetCollection.new(Pet.new(1)) }
    let(:int) { 13 }
    let(:float) { 100.01 }
    let(:float_str) { '100.01' }
    let(:string) { 'String' }
    let(:date) { Date.new(2017, 1, 2) }
    let(:time_zone) { ActiveSupport::TimeZone.new('Eastern Time (US & Canada)') }
    let(:date_like) { ActiveSupport::TimeWithZone.new(DateTime.now.utc, time_zone) }
    let(:date_str) { '2017-01-02' }
    
    it '::max_values returns array of max values at each index' do
      expect(Util.max_values([[10, -1], [3, 1, 2]])).to eql([10, 1, 2])
    end
    
    it '::max_values will always return positive values' do
      expect(Util.max_values([[-1], [0]])).to eql([1])
      expect(Util.max_values([[0.0], [0]])).to eql([1])
      expect(Util.max_values([[0.1], [0]])).to eql([0.1])
    end
    
    it '::array_of_arrays? returns true if item is an array of arrays' do
      expect(Util.array_of_arrays?([[-1], [3, '1']])).to eql(true)
      expect(Util.array_of_arrays?([[]])).to eql(true)
      expect(Util.array_of_arrays?([])).to eql(false)
      expect(Util.array_of_arrays?([[], {}])).to eql(false)
    end
    
    it '::multiplier returns float for pixels:data_value ratio' do
      expect(Util.multiplier(11, 200, 6)).to eql(18.181818)
      expect(Util.multiplier(100, 16, 6)).to eql(0.16)
    end
    
    it '::safe_to_dec attempts to_d and returns 0.0 if failed' do
      expect(Util.safe_to_dec(int)).to eql(int.to_d)
      expect(Util.safe_to_dec(float_str)).to eql(float)
      expect(Util.safe_to_dec(string)).to eql(0.0)
      expect(Util.safe_to_dec(date)).to eql(2_457_756.0)
    end
    
    it '::date_like? returns true if a date-time object that is not a Date' do
      expect(Util.date_like?(date_like)).to eql(true)
      expect(Util.date_like?(int)).to eql(false)
      expect(Util.date_like?(float)).to eql(false)
      expect(Util.date_like?(date)).to eql(false)
      expect(Util.date_like?(string)).to eql(false)
    end
    
    it '::date_label returns a label for a value user thinks is a date' do
      expect(Util.date_label(2_457_756.0)).to eql(date_str)
      expect(Util.date_label(date)).to eql(date_str)
      expect(Util.date_label([1, 2])).to eql('[1, 2]')
      expect(Util.date_label(pets)).to_not be(nil)
    end
    
    it '::grid_index returns item index for 2x2 matrix' do
      expect(Util.grid_index(3, 1, 2)).to eql(7)
      expect(Util.grid_index(3, 0, 1)).to eql(3)
    end
    
    it '::scaled_position returns position of n on line ab of scale_length' do
      expect(Util.scaled_position(13, 0, 50, 315) - 81.9).to be < 0.001
      expect(Util.scaled_position(0.333, -1, 1, 400)).to eql(266.60000000000001)
    end
    
    it '::scale returns scale min, max, and interval for min and max range' do
      expect(Util.scale(11, 66)).to eql([10, 70, 10]) # basic integer test
      expect(Util.scale(10, 70)).to eql([0, 80, 10]) # buffer if non-zero exact match
      expect(Util.scale(0, 1)).to eql([0, 1.5, 0.5]) # force border at zero if min or max match
      expect(Util.scale(-1, 0)).to eql([-1.5, 0, 0.5]) # force border at zero if min or max match
      expect(Util.scale(-300.8, 90_010)).to eql([-10_000, 100_000, 10_000]) # negative min
      expect(Util.scale(-300.8, -25.1)).to eql([-400, 0, 100]) # negative min and max
      expect(Util.scale(1, 0)).to eql([0, 1, 1]) # switched max and min
    end
    
    it '::scale_interval returns scale interval for min and max range' do
      expect(Util.scale_interval(10, 66)).to eql(10)
      expect(Util.scale_interval(0, 1)).to eql(0.5)
      expect(Util.scale_interval(101, 110)).to eql(1)
      expect(Util.scale_interval(-300.8, 90_010)).to eql(10_000)
      expect(Util.scale_interval(1, 0)).to eql(0.5)
    end
  end
end
