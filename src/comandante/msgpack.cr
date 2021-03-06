require "msgpack"
require "comandante"

module Comandante
  module Helper
    # Writes serializable data to file
    def self.write_msgpack(data, file, mode = "w") : Nil
      File.open(file, mode) do |io|
        data.to_msgpack(io)
      end
    end

    # Reads data from file - first/only object in file
    #
    # - Asserts file exists
    # - Raises `MessagePack::EofError` if file is empty
    # - Raises MessagePack::TypeCastError if not the correct type
    #
    # NOTE: you pass an object of the desired type
    def self.read_msgpack(file, data)
      Helper.assert_file(file)

      File.open(file, "r") do |io|
        data = data.class.from_msgpack(io)
      end

      return data
    end

    # Reads data from file - all objects in a file

    # - Asserts file exists
    # - Raises MessagePack::TypeCastError if not the correct type
    #
    # NOTE: you pass an object of the desired type
    def self.read_msgpack(file, data, &block) : Nil
      Helper.assert_file(file)

      File.open(file, "r") do |io|
        begin
          data = data.class.from_msgpack(io)

          while !data.nil?
            yield data
            data = data.class.from_msgpack(io)
          end
        rescue MessagePack::EofError
          # then we are done
        end
      end
    end
  end
end
