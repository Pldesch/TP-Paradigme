

declare FiFib F
fun {FiFib} 

    fun {F N1 N2}
        fib(N2 fun {$} {F N2 N1+N2} end)
    end

    {F 0 1} % Appel initial à F
end

% Fonction utilitaire permettant le débug de FiFib
% Res est la résultat de la fonction à afficher et N est le nombre d'itération restantes.
declare TraverseFib
fun {TraverseFib Res N} 
    if N == 0 then 'Finished'
    else {Browse Res} {TraverseFib {Res.2} N-1} 
    end
end

{Browse {TraverseFib {FiFib} 10}}
