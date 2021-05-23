declare
proc {ForCollect Xs P Ys}
  Acc={NewCell Ys}
  proc {C X} R2 in @Acc=X|R2 Acc:=R2 end
in
  for X in Xs do {P C X} end @Acc=nil
end

proc{ForCollectDecl Xs Proc Ys} 
  case Xs
    of H|T then 
      local
        R2
      in
        {Proc proc{$ X} R2=X end H}
        Ys = R2|{ForCollectDecl T Proc}
      end
    [] nil then Ys = nil
  end
end

{Browse {ForCollectDecl [0 2 4 6 8]
	 proc {$ Collect X} {Collect X div 2} end}}



{Browse {ForCollect [0 2 4 6 8]
	 proc {$ Collect X} {Collect X div 2} end}}