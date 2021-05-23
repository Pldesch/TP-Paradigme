%EX5

declare
fun{Counter Xs}
  fun{CounterAux Xs S}
    fun{C A S}
      case S 
        of H|T then
          if H.1==A then A#H.2+1|T
          else H|{C A T}
          end
        [] nil then
          A#1|nil
      end
    end
    A
  in
    thread 
    case Xs of H|T then
      A={C H S}
      A|{CounterAux T A}
    end
    end
  end
in
  {CounterAux Xs nil}
end

local InS in
{Browse {Counter InS}}
InS=a|b|a|c|nil
end

