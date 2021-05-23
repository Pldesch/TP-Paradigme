%EX3

declare
fun {Not X} 1-X end
fun {And X Y} X*Y end
fun {Or X Y} (X+Y)-(X*Y) end
fun {Xor A B} (A + B) mod 2 end

declare
fun {MakeBinaryGate F}
   fun {$ Xs Ys}
      fun {Loop Xs Ys}
         case Xs|Ys
         of (X|Xr)|(Y|Yr) then {F X Y}|{Loop Xr Yr}
         end
      end
   in
      thread {Loop Xs Ys} end
   end
end


NorG = {MakeBinaryGate fun{$ A B} 1-(A+B)+(A*B) end}

local R=1|1|1|0|_ S=0|1|0|0|_ Q NotQ
  proc {Bascule Rs Ss Qs NotQs}
    {NorG Rs 0|NotQs Qs}
    {NorG Ss 0|Qs NotQs}
  end
in
  {Bascule R S Q NotQ}
  {Browse Q#NotQ}
end
