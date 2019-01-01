require 'ffi'

module LibTest
  extend FFI::Library

  ffi_lib 'librust_from_ruby.dylib'

  attach_function :foo, [], :int
end

LibTest::foo
