

%=========================================================================================

% Question 1 :
% Premiere version :

%=========================================================================================
declare
fun {PremierHelper N M}
   if M == N then true elseif N mod M \= 0 then {PremierHelper N M+1} else false
   end
end


declare
fun {Premier N}
   {PremierHelper N 2}
end

{Browse {Premier 3}}
{Browse {Premier 4}}
{Browse {Premier 5}}
{Browse {Premier 6}}

% Deuxieme version :

declare
fun {PremierHelper N M}
   if M*M > N then true
   elseif N mod M \= 0 then {PremierHelper N M+1}
   else false
   end
end

{Browse {Premier 3}}
{Browse {Premier 4}}
{Browse {Premier 5}}
{Browse {Premier 6}}
{Browse {Premier 41}}
{Browse {Premier 51}}


% Autre manière sans devoir définir PremierHelper (c'est parfois plus joli)
declare
fun {Premier N}
   fun {PremierHelper N M}
      if M*M > N then true
      elseif N mod M \= 0 then {PremierHelper N M+1}
      else false
      end
   end
   in
   {PremierHelper N 2}
end

{Browse {Premier 3}}
{Browse {Premier 4}}
{Browse {Premier 5}}
{Browse {Premier 6}}
{Browse {Premier 41}}
{Browse {Premier 51}}


% Question 2 :

declare 
fun {Fib N}
   fun {FibHelper N1}
      case N1 
      of 0 then 0
      [] 1 then 1
      else 
         {FibHelper N1-1} + {FibHelper N1-2}
      end
   end
   in
   {FibHelper N-1}
end
{Browse {Fib 1}}
{Browse {Fib 2}}
{Browse {Fib 3}}
{Browse {Fib 4}}

local Fib in
   fun {Fib N}
      fun {FibHelper N1 A1 A2}
         if N1 < N then {FibHelper N1+1 A2 A2+A1}
         else A1 
         end
      end
      in 
      {FibHelper 1 0 1}
   end
   {Browse {Fib 1}}
   {Browse {Fib 2}}
   {Browse {Fib 3}}
   {Browse {Fib 4}}
end

local Fib in 
    proc {Fib N ?R}
        local FibHelper One Zero in
            proc {FibHelper N1 A1 A2}
                local N2 A3 Bool in
                    Bool = N1 < N
                    N2 = N1 + 1
                    A3 = A2 + A1
                    if Bool then {FibHelper N2 A2 A3}
                    else R = A1
                    end
                end
            end
            One = 1
            Zero = 0
            {FibHelper One Zero One}
        end
    end
    local Res in
    Res = {Fib 4}
    {Browse Res}
    end
end


%=========================================================================================

% Question 4 :

%=========================================================================================

% Implémentation de Pgcd par l'algorithme d'Euclide
declare
fun {Pgcd M N}
   if N == 0 then M
   else {Pgcd N M mod N}
   end
end

{Browse {Pgcd 453 18}}

% Implémentation de Ppcm par propriété mathématique : (M*N)/PGCD(M, N) est le PPCM (du fait que (M*N)/(PGCD(M,N)^2 < Max(M, N)))
declare
fun {Ppcm M N}
   M * N div {Pgcd M N}
end

{Browse {Ppcm 453 18}}


%=========================================================================================

% Question 6 :

%=========================================================================================

% La première partie du problème reviens en fait simplement à calculer le nombre de diviseurs de N
declare
fun {NombrePavages N}

   fun {Helper D A}
      if D == 0 then A 
      elseif N mod D == 0 then {Helper D-1 A+1}
      else {Helper D-1 A}
      end
   end 
   in 
   {Helper N div 2 1} % Taking N div 2 because we're sure that there will not be 
   % any divider of N between N/2 and N, and initiate A at 1 for the case N = N which is always true
end

{Browse {NombrePavages 6}} % 4 : 1 2 3 6
{Browse {NombrePavages 1234}} % 4 : 1 2 617 1234

% La seconde partie de la sous question consiste en fait à additionner le carré des diviseurs de N
declare 
fun {NombrePaves N}
   fun {Helper D A}
      if D == 0 then A 
      elseif N mod D == 0 then {Helper D-1 A+D*D}
      else {Helper D-1 A}
      end
   end 
   in 
   {Helper N div 2 N*N} % Taking N div 2 because we're sure that there will not be 
   % any divider of N between N/2 and N, and initiate A at N*N for the case N = N which is always true
end

{Browse {NombrePaves 6}} % 50 : 1*1 + 2*2 + 3*3 + 6*6
{Browse {NombrePaves 1234}} %  1 903 450: 1*1 + 2*2 + 617*617 + 1234*1234


%=============================================================================

% Question 5 :

%=============================================================================

declare 
fun {Numero N}

   fun {Floor Float}
      if {IntToFloat {FloatToInt Float}} - Float < 0.0 then {FloatToInt Float + 1.0}
      else {FloatToInt Float}
      end
   end
   in
   local Q First in
      Q = {Floor (~3.0 + {Sqrt 9.0 + 8.0*{IntToFloat N}})/2.0}
      First = Q*(Q+1) div 2
      couple(Q - (N-First) N-First)
   end
end

{Browse {Numero 7}}


declare 
fun {Numero N}

   fun {GetFirstNumber Diag Number}
      if Number =< N then {GetFirstNumber Diag + 1 Number + Diag + 1}
      else carac(Diag-1 Number - Diag)
      end
   end 
   in

   local Carac in
      Carac = {GetFirstNumber 0 0}
      couple(Carac.1 - (N - Carac.2) N - Carac.2)
   end
end
{Browse {Numero 10}}
