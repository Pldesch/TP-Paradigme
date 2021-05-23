declare
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

fun{Portier}
  S
  proc{Loop S State}
    case S of H|T then
      case H
        of getIn(N) then {Loop T State+N}
        [] getOut(N) then {Loop T State-N}
        [] getCount(N) then N = State {Loop T State}
      end
    end
  end
in
  thread {Loop S 0} end
  {NewPort S}
end

declare N
P={Portier}
{Send P getIn(8)}
{Send P getOut(3)}
{Send P getCount(N)}
{Browse N}
{Send P getIn(10)}

