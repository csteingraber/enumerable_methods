require "enumerable_methods"

describe "Enumerable" do
  let(:array) { [1, 2, 3] }
  let(:hash) { {chris: 22, breana: 23} }

  describe "::my_each" do
    context "when called on an Array" do
      it "returns itself" do
        expect(array.my_each {} ).to eq(array)
      end

      it "passes each element into the block" do
        expect { |block| array.my_each(&block) }.to yield_successive_args(1, 2, 3)
      end
    end

    context "when called on a Hash" do
      it "returns itself" do
        expect(hash.my_each {}).to eq(hash)
      end

      it "passes each key and value into the block" do
        expect { |block| hash.my_each(&block) }.to yield_successive_args([:chris, 22], [:breana, 23])
      end
    end
  end

  describe "::each_with_index" do
    it "returns the array it was called on" do
      expect(array.each_with_index {}).to eq(array)
    end

    it "passes each element and corresponding index into the block" do
      expect { |b| array.each_with_index(&b) }.to yield_successive_args([1, 0], [2, 1], [3, 2])
    end
  end

  describe "::my_select" do
    context "when called on an Array" do
      context "with elements that yield returned true for" do
        it "returns an array of those elements" do
          expect(array.my_select { |a| a > 0 }).to eq([1, 2, 3])
        end

        it "returns an array of those elements" do
          expect(array.my_select { |a| a < 0 }).to eq([])
        end
      end

      it "passes each element into the block" do
        expect { |b| array.my_select(&b) }.to yield_successive_args(1, 2, 3)
      end
    end

    context "when called on a Hash" do
      context "with key and value pairs that yield returned true for" do
        it "returns a hash of those key,value pairs" do
          expect(hash.my_select { |k, v| k == :chris }).to eq({chris: 22})
        end

        it "returns a hash of those key,value pairs" do
          expect(hash.my_select { |k, v| k == :sinai }).to eq({})
        end
      end

      it "passes each key,value pair into the block" do
        expect { |b| hash.my_select(&b) }.to yield_successive_args([:chris, 22], [:breana, 23])
      end
    end
  end

  describe "::my_all?" do
    context "when called on an array" do
      it "returns true if the block yields true for each element" do
        expect(array.my_all? { |a| a.instance_of? Fixnum }).to eq(true)
      end

      it "returns false if the block yields false at least once" do
        expect(array.my_all? { |a| a != 3 }).to eq(false)
      end

      it "passes each element into the block" do
        expect { |b| array.my_all?(&b) }.to yield_successive_args(1, 2, 3)
      end
    end

    context "when called on a hash" do
      it "returns true if the block yields true for each key,value pair" do
        expect(hash.my_all? { |k, v| k.instance_of? Symbol }).to eq(true)
      end

      it "returns false if the block yields false at least once" do
        expect(hash.my_all? { |k, v| v.instance_of? Symbol }).to eq(false)
      end

      it "passes each key,value pair into the block" do
        expect { |b| hash.my_all?(&b) }.to yield_successive_args([:chris, 22], [:breana, 23])
      end
    end
  end

  describe "::my_any?" do
    context "when called on an array" do
      it "returns true if the block yields true for any element" do
        expect(array.my_any? { |a| a == 1 }).to eq(true)
      end

      it "returns false if the block yields false for each element" do
        expect(array.my_any? { |a| a == 0 }).to eq(false)
      end

      it "passes each element into the block" do
        expect { |b| array.my_any?(&b) }.to yield_successive_args(1, 2, 3)
      end
    end

    context "when called on a hash" do
      it "returns true if the block yields true for any key,value pair" do
        expect(hash.my_any? { |k, v| k == :chris }).to eq(true)
      end

      it "returns false if the block yields false at least every time" do
        expect(hash.my_any? { |k, v| v == 24 }).to eq(false)
      end

      it "passes each key,value pair into the block" do
        expect { |b| hash.my_any?(&b) }.to yield_successive_args([:chris, 22], [:breana, 23])
      end
    end
  end

  describe "::my_none?" do
    context "when called on an array" do
      it "returns true if the block yields false for every element" do
        expect(array.my_none? { |a| a == 0 }).to eq(true)
      end

      it "returns false if the block yields true at least once" do
        expect(array.my_none? { |a| a == 1 }).to eq(false)
      end

      it "passes each element into the block" do
        expect { |b| array.my_none?(&b) }.to yield_successive_args(1, 2, 3)
      end
    end

    context "when called on a hash" do
      it "returns true if the block yields false for every key,value pair" do
        expect(hash.my_none? { |k, v| k == :sinai }).to eq(true)
      end

      it "returns false if the block yields true at least once" do
        expect(hash.my_none? { |k, v| v == 23 }).to eq(false)
      end

      it "passes each key,value pair into the block" do
        expect { |b| hash.my_none?(&b) }.to yield_successive_args([:chris, 22], [:breana, 23])
      end
    end
  end
end