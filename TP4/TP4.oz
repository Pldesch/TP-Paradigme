
% Question 1 :

% Lorsqu'une procédure est définie, on stocke dans une
% variable le code de cette procédure ainsi que son environnement contextuel
% cette variable est alors liée à l'identificateur utilisé.

local P in
  local Z in
    Z=1
    proc {P X Y} Y=X+Z end
  end
  local B A in
    A=10
    {P A B}
    {Browse B}
  end
end

% Lorsque P est définie, on aura l'environnement :
% E = {Z -> z, P -> p} 
% et la mémoire (z = 1, p = (proc {$ X Y} Y = X + Z end, E_c = {Z -> z}))

% Lors de l'appel de P, il faudra créer une nouvelle instruction sémantique :
% lors de l'appel de P, on à un environnement du type : E = {P ->p, A -> a, B ->b}
% et une mémoire (a = 10, p = (proc ... end, E_c), b)
% La nouvelle instruction sémantique sera alors :
% {Y = X + Z, E_p = {Z -> z, Y -> b, X -> a}} ce qui résultera en l'assignation de 11 à b


% Question 2 :

declare
fun {MakeMulFilter N}
  fun {$ I}
    if I mod N == 0 then true
    else false
    end
  end
end
fun {Filter L F}
  case L 
  of nil then nil
  [] H|T then 
    if {F H} == true then H|{Filter T F}
    else {Filter T F}
    end
  end
end

local MulFilter5 MulFilter7 in
  MulFilter5 = {MakeMulFilter 5}
  MulFilter7 = {MakeMulFilter 7}
%  {Browse {MulFilter5 10}}
%  {Browse {MulFilter7 14}}
%  {Browse {MulFilter7 10}}
%  {Browse {MulFilter5 14}}
end

declare
A = [1 2 3 4]
B = [3 4 5 6]
C = [5 6 7 8]
fun {IsPrime I}
  fun {IsPrimeHelper N}
    if N == 1 then true
    elseif I mod N == 0 then false
    else {IsPrime N-1}
    end
  end
  in 
  {IsPrimeHelper I-1}
end
{Browse {Filter A IsPrime}} % output : [2 3]
{Browse {Filter B IsPrime}} % output : [3 5]
{Browse {Filter C IsPrime}} % output : [5 7]
  
local TestFunc in
  fun {TestFunc I}
    if I < 5 then true
    else false
    end
  end

%  {Browse {Filter A TestFunc}} % output : [1 2 3 4]
%  {Browse {Filter B TestFunc}} % output : [3 4]
%  {Browse {Filter C TestFunc}} % output : nil
end

local Even in 
  Even = {MakeMulFilter 2}

%  {Browse {Filter A Even}} % output : [2 4]
%  {Browse {Filter B Even}} % output : [4 6]
%  {Browse {Filter C Even}} % output : [6 8]
end

local MultOf3 in
  MultOf3 = {MakeMulFilter 3}

%  {Browse {Filter A MultOf3}} % output : [3]
%  {Browse {Filter B MultOf3}} % output : [3 6]
%  {Browse {Filter C MultOf3}} % output : [6]
end

local Y LB in
  Y=10
  proc {LB X ?Z}
    if X>=Y then Z=X
    else Z=Y 
    end
  end
  local Y=15 Z in
    {LB 5 Z}
    {Browse Z}
  end
end

local Y LB in 
  Y = 10 
  proc {LB X ?Z}               % Début proc : arg = X
    local Bool in 
      Bool = X >= Y
      if Bool then Z = X
      else Z = Y
      end
    end                        % Fin proc
  end
  local Y Z Five in            % Début local
    Y = 15
    Five = 5
    {LB Five Z}
    {Browse Z}                
  end                          % fin local
end