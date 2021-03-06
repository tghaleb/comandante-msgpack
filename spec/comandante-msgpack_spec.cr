require "./spec_helper"

include Comandante

describe Comandante::Helper do
  it "reading single object work" do
    data_a = [1, 2, 3]

    Cleaner.tempfile do |f|
      Helper.write_msgpack(data_a, f)

      data = Helper.read_msgpack(f, Array(Int32).new)
      data.should eq(data_a)
    end
  end

  it "reading multiple objects should work" do
    data_a = [1, 2, 3]
    data_b = [3, 2, 3]
    results = Array(Array(Int32)).new

    Cleaner.tempfile do |f|
      Helper.write_msgpack(data_a, f)
      Helper.write_msgpack(data_b, f, mode = "a")

      Helper.read_msgpack(f, Array(Int32).new) do |data|
        results << data
      end
      results[0].should eq(data_a)
      results[1].should eq(data_b)
    end
  end
end
