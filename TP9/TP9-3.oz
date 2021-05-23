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