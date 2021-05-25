%EX1

declare
fun{Reverse Xs}
  A = {NewCell nil}
in
  for I in Xs do A:=I|@A end
  @A
end

{Browse {Reverse [0 1 2 3]}}

%EX2

declare
fun{NewStack}
  A = {NewCell nil}
  fun{Pop}
    case @A
      of nil then nil
      [] H|T then A:=T H 
    end
  end

  proc{Push X}
    A:= X|@A
  end

  fun{IsEmpty}
    @A == nil
  end
in 
  stack(isEmpty:IsEmpty pop:Pop push:Push)
end

declare
fun{Eval Xs}
  S = {NewStack}
  fun{EvalAux Xs}
    case Xs
      of H|T then
        case H
          of '+' then {S.push {S.pop}+{S.pop}} {EvalAux T}
          [] '-' then {S.push ~{S.pop}+{S.pop}} {EvalAux T}
          [] '*' then {S.push {S.pop}*{S.pop}} {EvalAux T}
          [] '/' then {S.push {S.pop} div {S.pop}} {EvalAux T}
          else {S.push H} {EvalAux T}
        end
      [] nil then {S.pop}
    end
  end
in
  {EvalAux Xs}
end

{Browse {Eval [13 45 '+' 89 17 '-' '*']}}

