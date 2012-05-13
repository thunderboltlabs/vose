require 'bundler/setup'
require 'minitest/spec'
require 'minitest/autorun'
require 'vose'

module MiniTest::Assertions
  def assert_vose_probability(probabilities, results)
    probabilities.each_with_index do |probablity, i|
      percentage = results.count(i) / results.size.to_f
      assert_in_delta probablity, percentage, 1
    end
  end
end

Array.infect_an_assertion :assert_vose_probability, :must_match_probability
