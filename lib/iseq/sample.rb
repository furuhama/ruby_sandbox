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
