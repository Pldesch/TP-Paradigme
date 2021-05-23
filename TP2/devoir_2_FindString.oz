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