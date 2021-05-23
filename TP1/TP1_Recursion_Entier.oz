% Question 1 :

declare 
fun {Sum N}
   fun {SumHelper I A}
      if I == N+1 then A
      else {SumHelper I+1 A+I*I}
      end
   end
   in
   {SumHelper 1 0}
end

{Browse {Sum 6}}

% Question 2 :

% L'accumulateur est A, il est par d�faut initialis� � 0
% Pour ce qui est de l'invariant :
%      Au d�but de l'it�ration i : A est compos� des i-1 derniers digits de N_init (dans l'ordre inverse) et N est compos� des i+1 premiers digits de N_init (dans l'ordre)
%      Pendant l'it�ration i : Le i�me digits de N_init va �tre ajout� au d�but de A et retir� de la fin de N
%      A la fin de l'it�ration i :  A est compos� des i derniers digits de N_init (dans l'ordre inverse) et N est compos� des i premiers digits de N_init (dans l'ordre)
declare
fun {MirrorHelper N A}
   if N == 0 then A
   else {MirrorHelper (N div 10) (A*10 + N mod 10)}
   end
end

declare
fun {Mirror N}
   {MirrorHelper N 0}
end

{Browse {Mirror 12345}}

% Question 3 :

% La question etait de compter le nombre de chiffres dans un nombre entier positif.
% Le premier appel renvoie 6, le second 4, le troisieme 1 et le dernier 1

% Verification :

declare
fun {Foo N}
   if N<10 then 1
   else 1+{Foo (N div 10)}
   end
end

{Browse {Foo 123456}}
{Browse {Foo 3211}}
{Browse {Foo 0}}
{Browse {Foo ~666}}


% Question 4 :

% Cette seconde reponse est egalement correcte, la seule majeure difference est 
% qu'elle a utilise un accumulateur et une fonction auxiliaire pour permettre une recursion.

% Verification:
declare
local
   fun {FooHelper N Acc}
      if N<10 then Acc+1
      else {FooHelper (N div 10) Acc+1}
   end
end
in
   fun {Foo N}
      {FooHelper N 0}
   end
end

{Browse {Foo 123456}}
{Browse {Foo 3211}}
{Browse {Foo 0}}
{Browse {Foo ~666}}

% Ca fonctionne.

% Question 5 :

declare 
proc {BrowseNumber N}
   {Browse N}
   if N > 0 then {BrowseNumber N-1}
   end
end

{BrowseNumber 4}
