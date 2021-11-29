# Comandante/Msgpack

An add-on for [Comandante](https://github.com/tghaleb/comandante/) for simplifying msgpack reading/writing.

## Installation

1. Add the dependency to your `shard.yml`:

```yaml
dependencies:
  comandante-msgpack:
    github: tghaleb/comandante-msgpack
```

2. Run `shards install`

## Usage


```crystal
require "comandante-msgpack/msgpack"
```

This is actually a wrapper around [msgpack-crsytal](https://github.com/crystal-community/msgpack-crystal/). 
By default `Crystal` types will be serializable, but for custom classes to
be serializable you need to add something like this to your class. 

```crystall
require "msgpack"

class Location
  include MessagePack::Serializable

  property lat : Float64
  property lng : Float64
end
```

You can either use the reader to write a large object to a file,

```crystall
Helper.write_msgpack(my_object, file)
```

Or use in an append mode and append multiple objects, of the same type, to file.

```crystall
objects.each do |x|
  Helper.write_msgpack(x, file, mode: "a")
end
```

If you need something more complicated than this use
[msgpack-crsytal](https://github.com/crystal-community/msgpack-crystal/) directly.

To read one object,

```crystall
data = Helper.read_msgpack(f, Array(Int32).new)
```

This will raise an error if you pass the wrong data type or in case the
file is empty.

To read multiple objects, for example multiple Arrays from a file,

```crystall
Helper.read_msgpack(f, Array(Float64).new) do |data|
  puts data.inspect
end 
```

:::Comandante::Helper

