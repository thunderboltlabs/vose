require "vose/version"

module Vose
  class InvalidArgumentException < RuntimeError; end;

  class AliasMethod
    attr_reader :limit, :prob

    def initialize(probabilities)
      raise InvalidArgumentException if probabilities.empty?
      raise InvalidArgumentException if probabilities.any?{|p| p < 0}

      @limit = probabilities.length
      sum = probabilities.reduce(:+)

      scale = @limit / sum.to_f
      scaled_probality = []
      probabilities.each do |p|
        scaled_probality << (p * scale)
      end

      @prob = Array.new(limit) { 0 }
      @alias = Array.new(limit) { 0 }

      preprocess(scaled_probality)
    end

    def preprocess(scaled_probality)
      small_worklist         = Array.new(limit) { 0 }
      large_worklist         = Array.new(limit) { 0 }
      small_worklist_counter = 0
      large_worklist_counter = 0

      0.upto(limit-1) do |j|
        if scaled_probality[j] > 1
          large_worklist[large_worklist_counter+=1] = j
        else
          small_worklist[small_worklist_counter+=1] = j
        end
      end

      while small_worklist_counter != 0 && large_worklist_counter != 0
        current_small_worklist_index = small_worklist[small_worklist_counter].to_i
        current_large_worklist_index = large_worklist[large_worklist_counter].to_i
        small_worklist_counter-=1
        large_worklist_counter-=1

        @prob[current_small_worklist_index] = scaled_probality[current_small_worklist_index]
        @alias[current_small_worklist_index] = current_large_worklist_index

        scaled_probality[current_large_worklist_index] = (scaled_probality[current_large_worklist_index] + scaled_probality[current_small_worklist_index]) - 1
        if scaled_probality[current_large_worklist_index] > 1
          large_worklist[large_worklist_counter] = large_worklist_counter
          large_worklist_counter+=1
        else
          small_worklist[small_worklist_counter] = current_large_worklist_index
          small_worklist_counter+=1
        end
      end

      while small_worklist_counter != 0
        small_worklist_counter-=1
        @prob[small_worklist[small_worklist_counter]] = 1
      end

      while large_worklist_counter != 0
        large_worklist_counter-=1
        @prob[large_worklist[large_worklist_counter]] = 1
      end
    end

    def next
      fair_die_roll = @limit * rand
      i = fair_die_roll.floor
      p = fair_die_roll - i
      p <= @prob[i] ? i : @alias[i]
    end
  end  
end