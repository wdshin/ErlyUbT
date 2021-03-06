-module(ubt_cong).

% sender side
% Initially Threshold = 65k MSS, CongWin = 1 MSS
sender_cong({Status, Threshold, CongWin}) ->
    case Status of
        normal when CongWin < Threshold ->
            { normal, Threshold, 2 * CongWin};
        normal when CongWin >= Threshold ->
            { normal, Threshold, CongWin + 1};
        
        triple_ack ->
            { normal, CongWin / 2, CongWin / 2};
        time_out ->
            { normal, CongWin / 2, 2 }
    end.

% receiver side

