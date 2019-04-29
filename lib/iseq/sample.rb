code = <<~CODE
  puts 'hello, world'
CODE

puts RubyVM::InstructionSequence.compile(code).disasm

__END__

== disasm: #<ISeq:<compiled>@<compiled>:1 (1,0)-(1,19)> (catch: FALSE)
0000 putself                                                          (   1)[Li]
0001 putstring                    "hello, world"
0003 opt_send_without_block       <callinfo!mid:puts, argc:1, FCALL|ARGS_SIMPLE>, <callcache>
0006 leave
