declare
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
