(: Cada modulo debe tener un namespace :)
module namespace pr = 'http://udem.edu.co/mins';

(:Servicio para crear problema:)
declare %rest:path("problem/{$pid}") 
%rest:POST( '{$problema}') 
updating function pr:crear-problema( $pid, $problema )
{
let $nombre := concat( $pid, '.xml' )

return if (db:exists( 'data', $nombre ) ) then
db:replace("data", $nombre, $problema ) 
else
db:add("data", $problema, $nombre ) 
};

(:Servicio para agregar el comentario a el problema :)
declare %rest:path("problem/{$pid}/review") 
%rest:POST( '{$review}')
updating function pr:review-problem( $pid, $review ){
let $ruta := concat( 'data/', $pid, '.xml' )
return insert node $review into collection($ruta)/problem 
};

(:Servicio para listar  problemas  :)
declare %rest:path("problem/{$id}") 
%rest:GET 
%rest:produces("text/xml", "application/xml" )
%output:method("xml")
function pr:get-problem-xml($id) {
let $p := doc( concat('data/',$id,'.xml') )
return $p
};




