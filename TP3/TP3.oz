% Question 1 :

declare
fun {Sum1 N}
  if N == 1 then 1
  else N*N + {Sum1 N-1} 
  end
end

% Traduction :

declare Sum in 
proc {Sum N ?R}
  local B One in 
    One = 1
    B = (N == One)
    if B then 
      R = One 
    else 
      local R1 N1 in
        N1 = N-One
        {Sum N1 R1}
        R = N*N + R1 % Il faut introduire une variable en plus pour faire le carré, et puis une autre pour l'addition
      end
    end
  end
end
{Browse {Sum 4}}

{Browse {Sum1 4}}


% Deuxième prog à traduire :
declare
fun {SumAux N Acc}
  if N == 1 then Acc + 1
  else {SumAux N-1 N*N+Acc} 
  end
end
fun {Sum N}
  {SumAux N 0}
end
{Browse {Sum 5}}

% Traduction :

declare Sum SumAux in
proc {SumAux N Acc ?R}
  local B One Accp in
    One = 1
    B = (N == One)
    if B then 
      Accp = Acc + 1
      R = Accp
    else
      local N1 R1 NewAcc NSquared in
        N1 = N - One
        NSquared = N*N 
        NewAcc = NSquared + Acc 
        {SumAux N1 NewAcc R1}
        R = R1
      end
    end
  end
end
proc {Sum N ?R}
  local Zero in
    Zero = 0
    {SumAux N Zero R}
  end
end
{Browse {Sum 5}}


% Question 3 :

declare 
L1 = [1]
L1Trad = '|'(1:1 2:nil)
{Browse L1}
{Browse L1Trad}

declare
L2 = [1 2 3]
L2Trad = '|'(1:1 2:'|'(1:2 2:'|'(1:3 2:nil)))
{Browse L2}
{Browse L2Trad}

declare
L3 = nil
L3Trad = il % Il n'y a pas de traduction car c'est un atome
{Browse L3}
{Browse L3Trad}

declare
L4 = state(4 f 3)
L4Trad = state(1:4 2:f 3:3)
{Browse L4}
{Browse L4Trad}

% Question 3 :

declare
proc {Q A} 
  {P A+1} 
end

% Environnement contextuel : E_c(Q) = {P -> p, A -> a} où p est la procédure en mémoire
% q = {proc {$} {P} end, {P -> p, A -> a}}

declare
proc {P} 
  {Browse A} 
end

% E_c(P) = {Browse -> browse, A -> a}, p = {proc {$} {P} end, E_c(P)}

local P Q in
  proc {P A R} 
    R=A+2 
  end

  % E_c(P) = {A -> a, R -> r}

  local P R in
    fun {Q A}
      {P A R}
      R
    end

    % E_c(Q) = {A -> a, P -> p, R -> r}

    proc {P A R} 
      R=A-2 
    end

    % E_c(P) = {A -> a, R -> r}
  end
  {Browse {Q 4}}
end

% Pronostic sur l'affichage : {Browse {Q 4}} = {Browse {P 4}} = {Browse 4-2}


% Devoir TP3 :

%% Programme 2
local Res in
  local Arg1 Arg2 in
    Arg1=7        % 1
    Res=Arg1*Arg2 % 3
    Arg2=6        % 2
  end
  {Browse Res}
end

%% Programme 2
local Res in
  local Arg1 Arg2 in
    thread Res=Arg1*Arg2 end
    Arg1=7        % 1
    Arg2=6        % 2
  end
  {Browse Res}
end

%% Programme 1
local Res in
  local Arg1 Arg2 in
    Arg1=7 % 1
    Arg2=6 % 2
    Res=Arg1*Arg2 % 3
  end
  {Browse Res}
end


% Question 5 :


local MakeAdd Add1 Add2 in % (init)
  proc {MakeAdd X Add} 
    proc {Add Y Z}
      Z=X+Y
    end
  end
  {MakeAdd 1 Add1}
  {MakeAdd 2 Add2}
  local V in
    {Add1 42 V} 
    {Browse V}
  end
  local V in
    {Add2 42 V} 
    {Browse V}
  end
end

% makeadd = (proc {$ X Add} Add = proc {$ Y Z} Z = X + Y end end, {})

% Premier appel de makeadd :
% (Add = proc {$ Y Z} Z = X + Y end, {X -> 1, Add -> add1})

% Second appel de makeadd :
% (Add = proc {$ Y Z} Z = X + Y end, {X -> 2, Add -> add2})


