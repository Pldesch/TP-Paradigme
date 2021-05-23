
% Question 1 :

{Browse 1} % Output : 1
{Browse 2} % Output : 2
{Browse 3} % Output : 3
{Browse 4} % Output : 4

% Question 2 :

{Browse (1 + 5) * (9 - 2)} % Output : 42
{Browse 19 - 970} % Output : ~951
{Browse 192 - 980 +191 * 967} % Output : 183909
{Browse (192 - 780) * (~3) - 191 * 967} % Output ~182933 

% Question 3 :

{Browse 123 + 456.0} % Code incorrect, on ne peut pas m�langer des float est des int

    % Solution :
{Browse 123 + 456} % Premi�re possibilit�
{Browse 123.0 + 456.0} % Deuxi�me possibilit�

% Question 4 :

declare X = (6 + 5)*(9 - 7)

{Browse X} % Output : 22
{Browse X + 5} % Output : 27

local Y in
   Y = 1
   {Browse Y} % Output : 1
end
{Browse Y} % Error, Y is outside the scope


% Question 5 :

declare
X=42
Z=~3
{Browse X} % (1)
{Browse Z}

declare Y=X+5
{Browse Y} % (2)

declare X=1234567890
{Browse X} % (3)

% Dans le premier bloc, le programme assigne 42 � X et -3 � Z, les proc�dures Browse affichent les valeurs des identificateurs
% Dans le second bloc, le programme assigne 42 + 5 = 47 � Y et la proc�dure Browse affiche la valeur de cet identificateur
% Dans le troisi�me bloc, le programme REassigne X � la valeur 1234567890 et la proc�dure Browse afficher cette valeur

% Lors de la r�assignation de X au troisi�me bloc, le programme modifie l'environnement qui liait initialement
% l'identificateur X � la variable 42 afin de maintenant lier X � 1234567890, la variable 42 n'est alors plus accessible.
% Si le langage est pourvu d'un Garbage Collector, la variable 42 sera �ventuellement retir�e de la m�moire.

% Si l'on r��x�cute la ligne (1) apr�s avoir ex�cut� les trois blocs, on pourra voir le r�sultat 1234567890 appara�tre.
% Ce r�sultat n'a rien de surprenant �tant donn� qu'apr�s avoir ex�cut� les 3 blocs, l'environnement comporte le lien X ==> 1234567890
% en m�moire, et c'est dont � cette variable que l'identificateur X est li�e.

% Par contre, r��x�cuter la ligne (2) apr�s �x�cution des 3 blocs ne change pas sa valeur, ceci est d� au fait que l'identificateur
% Y a �t� assign� � la variable 47, et non pas la variable X + 5.

% Question 6 :

{Browse 3 == 7}   % Output : false
{Browse 3 \= 7}   % Output : true
{Browse 3 < 7}    % Output : true
{Browse 3 =< 7}   % Output : true
{Browse 3 > 7}    % Output : false
{Browse 3 >= 7}   % Output : true

%Question 7 :

{Browse {Max 3 7}} % Output : 7
{Browse {Not 3==7}} % Output : true

% Solution au premier point :
local X Y Z in
   X = 7
   Y = 5
   Z = 6

   {Browse {Max X {Max Y Z}}} % Output : 7
end

local X Y Z in 
   X = 12
   Y = 65
   Z = 6

   {Browse {Max X {Max Y Z}}} % Output : 65
end

% Solution au second point :
declare
fun {Sign N}
   if N > 0 then 1
   elseif N < 0 then ~1
   else 0
   end
end

{Browse {Sign 1}} % Output : 1
{Browse {Sign ~65}} % Output : ~1
{Browse {Sign 0}} % Output : 0

% Question 8 :

local P Q X Y Z in % (1)
   fun {P X}
      X*Y+Z % (2)
   end
   fun {Q Y}
      X*Y+Z % (3)
   end
   X=1
   Y=2
   Z=3
   {Browse {P 4}}
   {Browse {Q 4}}
   {Browse {Q {P 4}}} % (4)
end

% Solution :

% P et Q sont respectivement les identificateurs de la premi�re et de la seconde fonction.
% X, Y et Z sont les identificateurs des variables 1,2 et 3.
% Le premier Browse retourne 4*2 + 3 = 11
% Le second Browse retourne 1*4 + 3 = 7
% Le troisi�me Browse retourne 1*(4*2 + 3) + 3 = 14

% Code modifi� :

local P Q X Y Z in % (1)
   fun {P X}
      X*Y+3 % (2)
   end
   fun {Q Y}
      X*Y+Z % (3)
   end
   X=1
   Y=1
   Z=2
   {Browse {P 4}}
   {Browse {Q 4}}
   {Browse {Q {P 4}}} % (4)
end

% Question 9 :

% Programme donn� :

declare X = 3
{Browse X + 2} % (1)
{Browse X * 2} % (2)

% Construction de Add2 et remplacement de la ligne (1)
declare fun {Add2} X + 2 end
{Browse {Add2}}

% Construction de Mul2 et remplacement de la ligne (2)
declare fun  {Mul2 X} X*2 end
{Browse {Mul2 X}}

% add2 = (fun Add2{X}{X+2}end, E = {X => 2})
% mul2 = (fun Mult2{X}{X*2} end, E = {})


