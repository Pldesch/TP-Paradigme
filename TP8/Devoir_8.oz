
/* Fonction d'updtate entre les états 

    Args :
    @Msg : message reçu par le stream d'input
    @State : L'état courant du serveur de comptage.

    Return : 
    @NewState : Le nouvel état courant du serveur de comptage
*/
declare
fun {UpdateCount Msg State}
    case State 
    of H|T then 
        case H
        of L#V then 
            if L == Msg then L#(V+1)|T
            else L#V|{UpdateCount Msg T} 
            end
        end
    [] nil then Msg#1|nil % Permet la fermeture de la liste
    end
end


% =======================Version sans ports======================

% Définition d'un stream d'input
declare
fun {Stream S}
    {Delay 500}
    case S of X|S2 then
        X|{Stream S2}
    [] nil then S = nil
    end
end

/* Etablissement du serveur de comptage :

    Args :
    @InStream : Le stream d'input du serveur de comptage
    @InitState : L'état initial du serveur de comptage

    Returns :
    @OutStream : Un stream d'output comprenant l'ensemble des 
                anciens états courant du serveur de comptage.
*/
declare
fun {Counter InStream InitState}
    {Delay 500}
    case InStream
    of nil then nil
    [] X|S2 then NewState in
        NewState = {UpdateCount X InitState} 
        NewState|{Counter S2 NewState}
    end
end

% Tests
{Browse 'Version sans ports'}
declare L S C in
{Browse S}
{Browse C} % S et C sont unbound
thread S = {Stream L} end % On bind S à un Stream
thread C = {Counter S nil} end % On bind C à un Stream, c'est le stream d'output du serveur de comptage
L = [a b b h a c f b a]



%====================== Version avec NewPortObject ==============

/* Implémentation d'un serveur de comptage à l'aide d'un Port

    Args :
    @Output : Le stream d'Output du serveur de comptage.

    Returns :
    @PortIn : Le port d'entrée du serveur de comptage.
*/
declare 
fun {Counter Output}
    local OutPort NewPortObject in 
        OutPort = {NewPort Output} % Permet de lier le port de sortie du stream au stream d'output
        fun {NewPortObject Behaviour Init}
            proc {MsgLoop S1 State}
                case S1 
                of Msg|S2 then
                    local NewState in
                        NewState = {Behaviour Msg State}
                        % Modification du serveur pour qu'il envoie son
                        % état courant au port de sortie.
                        % Sinon son état courant est un état strictement interne.
                        % Ceci permet "d'externaliser" son état courant.
                        {Send OutPort NewState} 
                        {MsgLoop S2 NewState}
                    end
                [] nil then skip
                end
            end
            in
            local Sin in
                thread {MsgLoop Sin Init} end
                {NewPort Sin}
            end
        end
        {NewPortObject UpdateCount nil} % Permet de renvoyer le port d'entrée du serveur
    end
end


% Fonction de test
declare 
proc {Test List Port}
    {Delay 500}
    case List
    of nil then skip
    [] H|T then 
        {Send Port H} 
        {Test T Port}
    end
end

{Browse 'Version avec Ports'}
declare
Out                   % Output stream
C = {Counter Out}     % Serveur de comptage
L                     % Future liste
{Test L C}

{Browse L}
{Browse Out}          % Stream d'output
{Browse C}            % Port d'entrée

L = [a b b h a c f b a] % On bind L à une liste.