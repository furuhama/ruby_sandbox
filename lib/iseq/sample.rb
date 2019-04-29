code1 = <<~CODE
  puts 'hello, world'
CODE
puts RubyVM::InstructionSequence.compile(code1).disasm
# == disasm: #<ISeq:<compiled>@<compiled>:1 (1,0)-(1,19)> (catch: FALSE)
# 0000 putself                                                          (   1)[Li]
# 0001 putstring                    "hello, world"
# 0003 opt_send_without_block       <callinfo!mid:puts, argc:1, FCALL|ARGS_SIMPLE>, <callcache>
# 0006 leave

code2 = <<~CODE
  def test(a, b, *arr, c)
    a + b + arr.length + c
  end

  test(1, 2, 3, 4, 5, 6)
CODE
puts RubyVM::InstructionSequence.compile(code2).disasm
# == disasm: #<ISeq:<compiled>@<compiled>:1 (1,0)-(5,22)> (catch: FALSE)
# 0000 putspecialobject             1                                   (   1)[Li]
# 0002 putobject                    :test
# 0004 putiseq                      test
# 0006 opt_send_without_block       <callinfo!mid:core#define_method, argc:2, ARGS_SIMPLE>, <callcache>
# 0009 pop
# 0010 putself                                                          (   5)[Li]
# 0011 putobject_INT2FIX_1_
# 0012 putobject                    2
# 0014 putobject                    3
# 0016 putobject                    4
# 0018 putobject                    5
# 0020 putobject                    6
# 0022 opt_send_without_block       <callinfo!mid:test, argc:6, FCALL|ARGS_SIMPLE>, <callcache>
# 0025 leave

# == disasm: #<ISeq:test@<compiled>:1 (1,0)-(3,3)> (catch: FALSE)
# local table (size: 4, argc: 2 [opts: 0, rest: 2, post: 1, block: -1, kw: -1@-1, kwrest: -1])
# [ 4] a@0<Arg>   [ 3] b@1<Arg>   [ 2] arr@2<Rest>[ 1] c@3<Post>
# 0000 getlocal_WC_0                a@0                                 (   2)[LiCa]
# 0002 getlocal_WC_0                b@1
# 0004 opt_plus                     <callinfo!mid:+, argc:1, ARGS_SIMPLE>, <callcache>
# 0007 getlocal_WC_0                arr@2
# 0009 opt_length                   <callinfo!mid:length, argc:0, ARGS_SIMPLE>, <callcache>
# 0012 opt_plus                     <callinfo!mid:+, argc:1, ARGS_SIMPLE>, <callcache>
# 0015 getlocal_WC_0                c@3
# 0017 opt_plus                     <callinfo!mid:+, argc:1, ARGS_SIMPLE>, <callcache>
# 0020 leave                                                            (   3)[Re]

code3 = <<~CODE
  def test(&block)
    yield
  end

  test do
    a = 10
    b = 2
    a + b
  end
CODE
puts RubyVM::InstructionSequence.compile(code3).disasm
# == disasm: #<ISeq:test@<compiled>:1 (1,0)-(3,3)> (catch: FALSE)
# local table (size: 4, argc: 2 [opts: 0, rest: 2, post: 1, block: -1, kw: -1@-1, kwrest: -1])
# [ 4] a@0<Arg>   [ 3] b@1<Arg>   [ 2] arr@2<Rest>[ 1] c@3<Post>
# 0000 getlocal_WC_0                a@0                                 (   2)[LiCa]
# 0002 getlocal_WC_0                b@1
# 0004 opt_plus                     <callinfo!mid:+, argc:1, ARGS_SIMPLE>, <callcache>
# 0007 getlocal_WC_0                arr@2
# 0009 opt_length                   <callinfo!mid:length, argc:0, ARGS_SIMPLE>, <callcache>
# 0012 opt_plus                     <callinfo!mid:+, argc:1, ARGS_SIMPLE>, <callcache>
# 0015 getlocal_WC_0                c@3
# 0017 opt_plus                     <callinfo!mid:+, argc:1, ARGS_SIMPLE>, <callcache>
# 0020 leave                                                            (   3)[Re]
# == disasm: #<ISeq:<compiled>@<compiled>:1 (1,0)-(9,3)> (catch: FALSE)
# == catch table
# | catch type: break  st: 0010 ed: 0015 sp: 0000 cont: 0015
# | == disasm: #<ISeq:block in <compiled>@<compiled>:5 (5,5)-(9,3)> (catch: FALSE)
# | == catch table
# | | catch type: redo   st: 0001 ed: 0016 sp: 0000 cont: 0001
# | | catch type: next   st: 0001 ed: 0016 sp: 0000 cont: 0016
# | |------------------------------------------------------------------------
# | local table (size: 2, argc: 0 [opts: 0, rest: -1, post: 0, block: -1, kw: -1@-1, kwrest: -1])
# | [ 2] a@0        | [ 1] b@1
# | 0000 nop                                                              (   5)[Bc]
# | 0001 putobject                    10                                  (   6)[Li]
# | 0003 setlocal_WC_0                a@0
# | 0005 putobject                    2                                   (   7)[Li]
# | 0007 setlocal_WC_0                b@1
# | 0009 getlocal_WC_0                a@0                                 (   8)[Li]
# | 0011 getlocal_WC_0                b@1
# | 0013 opt_plus                     <callinfo!mid:+, argc:1, ARGS_SIMPLE>, <callcache>
# | 0016 nop
# | 0017 leave                                                            (   9)[Br]
# |------------------------------------------------------------------------
# 0000 putspecialobject             1                                   (   1)[Li]
# 0002 putobject                    :test
# 0004 putiseq                      test
# 0006 opt_send_without_block       <callinfo!mid:core#define_method, argc:2, ARGS_SIMPLE>, <callcache>
# 0009 pop
# 0010 putself                                                          (   5)[Li]
# 0011 send                         <callinfo!mid:test, argc:0, FCALL>, <callcache>, block in <compiled>
# 0015 nop
# 0016 leave                                                            (   5)

# == disasm: #<ISeq:test@<compiled>:1 (1,0)-(3,3)> (catch: FALSE)
# local table (size: 1, argc: 0 [opts: 0, rest: -1, post: 0, block: 0, kw: -1@-1, kwrest: -1])
# [ 1] block@0<Block>
# 0000 invokeblock                  <callinfo!argc:0, ARGS_SIMPLE>      (   2)[LiCa]
# 0002 leave                                                            (   3)[Re]

code4 = <<~CODE
  def test(a:, b: 10, c: 20)
    a + b + c
  end

  test(a: 1, b: 2)
CODE
puts RubyVM::InstructionSequence.compile(code4).disasm
# == disasm: #<ISeq:<compiled>@<compiled>:1 (1,0)-(5,16)> (catch: FALSE)
# 0000 putspecialobject             1                                   (   1)[Li]
# 0002 putobject                    :test
# 0004 putiseq                      test
# 0006 opt_send_without_block       <callinfo!mid:core#define_method, argc:2, ARGS_SIMPLE>, <callcache>
# 0009 pop
# 0010 putself                                                          (   5)[Li]
# 0011 putobject_INT2FIX_1_
# 0012 putobject                    2
# 0014 opt_send_without_block       <callinfo!mid:test, argc:2, kw:[a,b], FCALL|KWARG>, <callcache>
# 0017 leave

# == disasm: #<ISeq:test@<compiled>:1 (1,0)-(3,3)> (catch: FALSE)
# local table (size: 4, argc: 0 [opts: 0, rest: -1, post: 0, block: -1, kw: 3@1, kwrest: -1])
# [ 4] a@0        [ 3] b@1        [ 2] c@2        [ 1] ?@3
# 0000 getlocal_WC_0                a@0                                 (   2)[LiCa]
# 0002 getlocal_WC_0                b@1
# 0004 opt_plus                     <callinfo!mid:+, argc:1, ARGS_SIMPLE>, <callcache>
# 0007 getlocal_WC_0                c@2
# 0009 opt_plus                     <callinfo!mid:+, argc:1, ARGS_SIMPLE>, <callcache>
# 0012 leave                                                            (   3)[Re]
