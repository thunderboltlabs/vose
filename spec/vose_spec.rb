require 'spec_helper'

describe Vose::AliasMethod do
  it "complains if the list of probabilities is empty" do
    probabilities = []
    lambda { 
      Vose::AliasMethod.new probabilities
    }.must_raise(Vose::InvalidArgumentException)
  end

  it "complinas if the probabilities aren't positive" do
    probabilities = [-0.5]
    lambda { 
      Vose::AliasMethod.new probabilities
    }.must_raise(Vose::InvalidArgumentException)
  end  

  it "sets the limit to the lenght of probabilities" do
    probabilities = [0.1, 0.9]
    vose = Vose::AliasMethod.new probabilities
    vose.limit.must_equal 2
  end

  # Yes, these are slow tests. Consider it an acceptance
  # level test :) Patches are welcome. Testing rand is hard or
  # brittle imho.
  describe "acceptance" do
    it "allows for possibilities which add up to more than 1" do
      probabilities = [1.2, 0.4, 0.4]
      vose = Vose::AliasMethod.new probabilities
      results = []
      100000.times { results << vose.next }
      
      sum = probabilities.reduce(:+) 
      expected_percentages = probabilities.map{|p| p/sum}
      results.must_match_probability expected_percentages
    end

    it "allows you choose the next probablity given your inputs" do
      probabilities = [0.1, 0.5, 0.4]
      vose = Vose::AliasMethod.new probabilities
      results = []
      100000.times { results << vose.next }
      results.must_match_probability probabilities
    end
  end
end