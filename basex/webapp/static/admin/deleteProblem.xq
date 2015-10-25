xquery version "3.0";
declare option output:method "html";
(:declare option output:method "html";:)
declare variable $idProblem as xs:string external := "idProblem";
let $db:=collection('problem')
  return delete node $db/problem[id = $idProblem]
(: Borrar un degenerado problema :)

 