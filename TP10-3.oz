declare

fun {StudentRMI}
  S 
in
  thread
    for ask(howmany:Beers) in S do
      Beers={OS.rand} mod 24
    end
  end
  {NewPort S}
end

fun {StudentCallBack}
  S
in
  thread
    for ask(howmany:P) in S do
      {Send P {OS.rand} mod 24}
    end
  end
  {NewPort S}
end

fun {CreateUniversity Size}
  fun {CreateLoop I}
    if I =< Size then
      % pour {Student} choisissez soit StudentRMI ou StudentCallBack,
      % défini plus haut, selon l'humeur de Charlotte
      {StudentRMI}|{CreateLoop I+1}
    else 
      nil 
    end
  end
in
  {CreateLoop 1}
end

proc{Charlotte L}
  Res Tot Moy Maxi Mini
in
  Res = {List.map L fun{$ S} B in {Send S ask(howmany:B)} B end}
  Tot = {List.foldL Res fun{$ A B} A+B end 0}
  Moy = Tot div {List.length Res}
  Maxi = {List.foldL Res Value.max Res.1}
  Mini = {List.foldL Res Value.min Res.1}
  {Browse Tot}
  {Browse Moy}
end

{Charlotte {CreateUniversity 10}}
