declare
%NOT WORKING
fun {NewPortObject Behaviour Init}
  proc {MsgLoop S1 State}
    case S1 
      of Msg|S2 then {MsgLoop S2 {Behaviour Msg State}}
      [] nil then skip
    end
  end
  Sin
in
  thread {MsgLoop Sin Init} end
  {NewPort Sin}
end

fun{Counter Xs L}
  case L
    of X|Xr then 
      if X.1==L then
        X.1#X.2+1|Xr
      else X|{Counter Xr L}
      end
    [] nil then L#1|nil
  end
end

P 
thread P={NewPortObject Counter nil} end
{Send P a}
