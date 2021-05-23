%EX1

declare P S
{NewPort S P}

{Send P foo}
{Send P bar}

{Browse S} %-> Browse foo|bar|_<future>

declare
proc{Print S}
  case S of H|T then {Browse H} {Print T} end
end
thread {Print S} end

