

declare
fun {Not B} (B + 1) mod 2 end
fun {And A B} A*B end
fun {Or A B} A*(1 - B) + B end

declare 
fun {NotGate InStream}
    case InStream 
    of X|S2 then 
        {Not X}|{NotGate S2}
    end
end
declare
fun {AndGate InStream1 InStream2}
    case InStream1#InStream2
    of (X1|S1)#(X2|S2) then 
        {And X1 X2}|{AndGate S1 S2}
    end
end
declare
fun {OrGate InStream1 InStream2}
    case InStream1#InStream2
    of (X1|S1)#(X2|S2) then 
        {Or X1 X2}|{OrGate S1 S2}
    end
end

declare 
fun {Simulate G Ss}
    case G 
    of gate(1:List value:Val) then
        thread {NotGate {Simulate List Ss}} end
    [] gate(1:List1 2:List2 value:Val) then
        case Val 
        of 'or' then thread {OrGate {Simulate List1 Ss} {Simulate List2 Ss}} end
        [] and  then thread {AndGate {Simulate List1 Ss} {Simulate List2 Ss}} end
        end
    [] input(X) then Ss.X 
    end
end

declare G S L 
{Browse S}
{Browse G}
{Browse L}
G = gate(value: 'or' 
         gate(value: 'and' input(x) input(y)) 
         gate(value: 'not' input(z)))
S = input(x:1|0|1|0|_ y:0|1|0|1|_ z:1|1|0|0|_)
L = {Simulate G S}