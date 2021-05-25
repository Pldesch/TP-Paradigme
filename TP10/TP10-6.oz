declare 
fun{NewQueue}
  S
  proc{Loop S State}
    fun{Add X State}
      case State
        of nil then X|nil
        [] H|T then H|{Add X T}
      end
    end
  in
    case S
      of H|T then 
        case H
          of enqueue(X) then {Loop T {Add X State}}
          [] dequeue(X) then
            case State
              of Xs|Xr then X=Xs {Loop T Xr}
              [] nil then X=nil {Loop T nil}
            end
          [] isEmpty(X) then X= State==nil {Loop T State}
          [] getElements(X) then X=State {Loop T State}
        end
    end
  end
in  
  thread {Loop S nil} end
  {NewPort S}
end

fun{IsEmpty Q}
  X
in  
  {Send Q isEmpty(X)}
  X
end

proc{EnQueue Q X}
  {Send Q enqueue(X)}
end

fun{Dequeue Q}
  X 
in
  {Send Q dequeue(X)}
  X
end

fun{GetElements Q}
  X 
in
  {Send Q getElements(X)}
  X
end

Q = {NewQueue}
{Browse {IsEmpty Q}}
{EnQueue Q 2}
{EnQueue Q 1}
{EnQueue Q 4}
{Browse {Dequeue Q}}
{Browse {IsEmpty Q}}
{Browse {GetElements Q}}