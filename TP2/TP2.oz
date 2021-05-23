
% Question 1 :
declare
L1 = '|'(a nil)
L2 = '|'(a '|'('|'(b '|'(c nil)) '|'(d nil)))
L3 = '|'(proc {$} {Browse 'oui'} end '|'(proc {$} {Browse 'non'} end nil))
L4 = '|'('est' '|'('une' '|'('liste' nil)))
L5 = '|'('|'(a '|'(p nil)) nil)

{Browse L1}
{Browse L2}
{Browse L3}
{Browse L4}
{Browse L5}

declare
L6 = '|'('ceci' L4)
{Browse L6}
{L3.1}
L7 = L2.2
{Browse L7}

declare
fun {Head L}
    L.1
end
fun {Tail L}
    L.2
end

{Browse {Head L4}}


% Question 2 :

declare 
fun {Length L}
    % Invariant = à l'itération i, Len est la longueur de la sous chaine des i premiers carac de L
    fun {LengthHelper L Len}
        if L.2 == nil then Len +1
        else {LengthHelper L.2 Len+1}
        end
    end
    in
    {LengthHelper L 0}
end

{Browse {Length L4}}
{Browse {Length [[b o r] i s]}}

% Question 3 :

declare
fun {Append L1 L2} 
    if L1 == nil then L2
    else '|'(L1.1 {Append L1.2 L2})
    end
end

{Browse {Append [r a] [p h]}} % affiche [r a p h]
{Browse {Append [b [o r]] [i s]}} % affiche [b [o r] i s]
{Browse {Append nil [l u i s]}} % affiche [l u i s]

% Question 4 :

declare
fun {IsList L}
    case L
    of nil then empty
    [] H|T then nonEmpty
    else other
    end
end

{Browse {IsList nil}}
{Browse {IsList [1 2]}}
{Browse {IsList 0}}

declare
fun {Head L}
    case L
    of nil then nil
    [] H|T then H 
    end
end
fun {Tail L}
    case L
    of nil then nil 
    [] H|T then T
    end
end
fun {Append L1 L2}
    case L1
    of nil then L2
    [] H|T then '|'(H {Append T L2})
    end
end
fun {Length L}
    fun {LenHelper L A}
        case L
        of nil then A 
        [] H|T then {LenHelper T A+1}
        end
    end
    in
    {LenHelper L 0}
end


{Browse {Head [1 2 3 4]}} % Output 1
{Browse {Head nil}} % Output nil
{Browse {Tail nil}} % Output nil
{Browse {Tail [1 2 3 4]}} % Output [2 3 4]
{Browse {Append [r a] [p h]}} % affiche [r a p h]
{Browse {Append [b [o r]] [i s]}} % affiche [b [o r] i s]
{Browse {Append nil [l u i s]}} % affiche [l u i s]

% Question 5 :

{Browse 0|[1 2 3]}

declare
fun {Take Xs N}
    case Xs
    of nil then nil
    [] H|T andthen N > 0 then H|{Take T N-1}
    else nil
    end
end

{Browse {Take [r a p h] 2}} % affiche [r a]
{Browse {Take [r a p h] 7}} % affiche [r a p h]
{Browse {Take [r [a p] h] 2}} % affiche [r [a p]]

declare 
fun {Drop Xs N}
    case Xs
    of nil then nil
    [] H|T andthen N > 0 then {Drop T N-1}
    else Xs 
    end
end

{Browse {Drop [r a p h] 2}} % affiche [p h]
{Browse {Drop [r a p h] 7}} % affiche nil
{Browse {Drop [r [a p] h] 2}} % affiche [h]


% Question 7 :
declare
Liste = [[1 2 3] [4 5 6]]
Liste2 = (1|2|3|nil)|(4|5|6|nil)|nil

{Browse Liste}
{Browse Liste}

% Question 8 :

declare 
fun {Prefix L1 L2}
    case L1                                      % On analyse L1
    of H1|T1 then                                % Dans le cas où il reste des éléments dans L1:
        case L2                                        % On analyse L2
        of H2|T2 then                                  % Si il reste des éléments dans L2 :
            if H1 == H2 then {Prefix T1 T2}                 % Et que ces éléments sont les mêmes, on peut tester les éléments suivants de L1 et L2
            else false                                      % Si les éléments ne sont pas les mêmes alors L1 n'est pas le préfixe de L2
            end
        [] nil then false                              % Si il ne reste plus d'éléments dans L2 alors ce ne sont pas les mêmes (L1 > L2 en taille)
        end
    [] nil then true                             % Si l'on atteint la fin de L1 sans soucis alors ce sont les mêmes.
    end
end

% Enumération des cas : 
% Soit L1 et L2 deux listes, on cherche à savoir si L1 est le préfixe de L2 

% Cas 1 : L1 est plus petit que L2 et n'est pas son préfixe ==> output : false
{Browse {Prefix [1 2 1] [1 2 3 4]}} % affiche false
% Cas 2 : L1 est plus grand que L2 et L2 n'est pas contenu dans L1 ==> output : false
{Browse {Prefix [5 4 3 2 1] [1 2 3 4]}} % affiche false
% Cas 3 : L1 est plus petit que L2 et est son préfixe ==> output : true
{Browse {Prefix [1 2 3] [1 2 3 4]}} % affiche true
% Cas 4 : L1 est plus grand que L2 et L2 est contenu dans L1 ==> output : false
{Browse {Prefix [1 2 3 4 5] [1 2 3 4]}} % affiche false

% NOTE : Les cas où L1 et L2 sont de longueurs nulles sont bien entendu compris dans les cas 1 et 2


declare
fun {FindString S T}
    fun {FSHelper Tail Index}
        case Tail                                                                % On analyse la queue de la liste Tail
        of nil then nil                                                          % Le cas où Tail est vide est notre "base case"
        [] H2|T2 then                                                            % Sinon on regarde la tête et la queue de Tail
            if {Prefix S Tail} == true then Index|{FSHelper T2 Index+1}          % Si S est le préfixe de Tail, on effectue un appel récursif en ajoutant Index au début du résultat
            else {FSHelper T2 Index+1}                                           % Sinon on effectue un appel récursif sans ajouter Index au début du résultat
            end
        end
    end
    in 
    {FSHelper T 1}
end

{Browse {FindString [a b a b] [a b a b a b]}} % affiche [1 3]
{Browse {FindString [a] [a b a b a b]}} % affiche [1 3 5]
{Browse {FindString [c] [a b a b a b]}} % affiche nil
{Browse {FindString [a b] [a b a]}} % affiche [1]
{Browse {FindString [1 2 3] [1 2]}} % affiche nil

