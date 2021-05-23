declare
fun{NewStack}
  S
  proc{Loop S State}
    case S
      of H|T then 
        case H
          of push(X) then {Loop T X|State} 
          [] pop(X) then
            case State
              of Xr|Xs then X=Xr {Loop T Xs}
              [] nil then {Browse empty} {Loop T nil}
            end
          [] isEmpty(X) then X= State==nil {Loop T State}
        end
    end
  end
in
  thread {Loop S nil} end
  {NewPort S}
end

proc{Push S X}
  {Send S push(X)}
end

fun{Pop S}
  X
in
  {Send S pop(X)}
  X
end

fun{IsEmpty S}
  X
in
  {Send S isEmpty(X)}
  X
end

declare
S = {NewStack}
{Browse {IsEmpty S}}
{Push S 2}
{Browse {IsEmpty S}}
{Browse {Pop S}}

{NewPort }