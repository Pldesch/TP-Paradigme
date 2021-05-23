declare
fun{Not N} 1-N end
fun{And X Y} X*Y end
fun{Or X Y} X+Y-X*Y end

fun{NotGate X}
  fun {Loop Xs}
   case Xs of X|Xr then {Not X}|{Loop Xr} end
  end
in
  thread {Loop X} end
end

fun{AndGate Xs Ys}
  fun{Loop Xs Ys}
    case Xs#Ys of (X|Xr)#(Y|Yr) then {And X Y}|{Loop Xr Yr} end
  end
in
  thread {Loop Xs Ys} end
end

fun{OrGate Xs Ys}
  fun{Loop Xs Ys}
    case Xs#Ys of (X|Xr)#(Y|Yr) then {Or X Y}|{Loop Xr Yr} end
  end
in
  thread {Loop Xs Ys} end
end

fun {Simulate G Ss}
   case G
   of gate(value:'or' G1 G2) then {OrGate {Simulate G1 Ss} {Simulate G2 Ss}}
   [] gate(value:'and' G1 G2) then {AndGate {Simulate G1 Ss} {Simulate G2 Ss}}
   [] gate(value:'not' G1) then {NotGate {Simulate G1 Ss}}
   [] input(A) then thread Ss.A end
   end
end


G=gate(value:'or'
gate(value:'and'
input(x)
input(y))
gate(value:'not' input(z)))

{Browse {Simulate G Ss}}






