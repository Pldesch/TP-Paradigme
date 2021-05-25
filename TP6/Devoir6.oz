% Question 3 :
declare
fun {NewStack} 
  local
    Stack = {NewCell nil}

    fun {IsEmpty} 
      @Stack == nil 
    end

    proc {Push X} 
      Stack := X|@Stack 
    end

    fun {Pop} Res in
      case @Stack 
      of nil then Res = nil
      [] H|T then
        Res = H
        Stack := T
      end
      Res 
    end
    
  in
    stack(isEmpty:IsEmpty push:Push pop:Pop)
  end
end

% On vient en fait de créer un objet "Stack" ayant une série de
% méthode agissant sur lui. On aurait également pu implémenter une
% structure de donnée abstraite (ADT) avec l'utilisation de "Wrapper".
% La différence principale entre ses deux possibilités est que 
% les objets encapsulent leur état (ils se souviennent de leur
% état entre deux appels de procédures) tandis que les ADT
% ne le font pas.

declare
Stack1={NewStack} % pile 1
Stack2={NewStack} % pile 2
{Browse {Stack1.isEmpty}} % affiche true;
{Stack1.push 13}
{Browse {Stack1.isEmpty}} % affiche false
{Browse {Stack2.isEmpty}} % affiche true
{Stack1.push 45}
{Stack2.push {Stack1.pop}}
{Browse {Stack2.isEmpty}} % affiche false
{Browse {Stack1.pop}} % affiche 13

declare
fun {Eval L} 
  local 
    Stack = {NewStack}
  in
    for H in L do 
      case H 
      of '+' then
        {Stack.push {Stack.pop} + {Stack.pop}}
      [] '-' then
        {Stack.push ~{Stack.pop} + {Stack.pop}}
      [] '*' then
        {Stack.push {Stack.pop} * {Stack.pop}}
      [] '/' then
        local 
          Den = {Stack.pop}
          Num = {Stack.pop}
        in 
          {Stack.push Num div Den}
        end
      else {Stack.push H} end
    end
    {Stack.pop}
  end
end
{Browse {Eval [13 45 '+' 89 17 '-' '*']}} % Affiche bien 4176
{Browse {Eval [13 45 '+' 89 '*' 17 '-']}} % Affiche bien 5145
{Browse {Eval [13 45 89 17 '-' '+' '*']}} % Affiche bien 1521
