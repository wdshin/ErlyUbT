-module(ubt_packer).
-export([unpack/1, pack/1]).

-include("ubt_header.hrl").

unpack(<<SrcPort : ?N_16,
      DstPort : ?N_16,
      SeqNo : ?N_32,
      AckNo : ?N_32,
      DataOffset :?N_4,
      Reserved :?N_6,
      %cflag begin
      Urg :?N_1,
      Syn :?N_1,
      Ack :?N_1,
      Rst :?N_1,
      Psh :?N_1,
      Fin :?N_1,
      %cflag end
      Wndw :?N_16,
      Checksum :?N_16,
      Urg_ptr :?N_16,
      Rest/binary>>) ->
      Header = #ubt_header{
            src_port = SrcPort,
            dst_port = DstPort,
            seq_no = SeqNo,
            ack_no = AckNo,
            syn = Syn,
            ack = Ack,
            rst = Rst,
            fin = Fin,
            wndw = Wndw
        },
      { Header, Rest }.

pack({Header, Rest}) ->
    {ubt_header, SrcPort, DstPort, SeqNo, AckNo, Syn, Ack, Rst, Fin, Wndw}
        = Header,
    { DataOffset, Reserved, Urg, Psh, Checksum, Urg_ptr}
        = { 0, 0, 0, 0, 0, 0},
    <<SrcPort : ?N_16,
      DstPort : ?N_16,
      SeqNo : ?N_32,
      AckNo : ?N_32,
      DataOffset :?N_4,
      Reserved :?N_6,
      %cflag begin
      Urg :?N_1,
      Syn :?N_1,
      Ack :?N_1,
      Rst :?N_1,
      Psh :?N_1,
      Fin :?N_1,
      %cflag end
      Wndw :?N_16,
      Checksum :?N_16,
      Urg_ptr :?N_16,
      Rest/binary>>.

     