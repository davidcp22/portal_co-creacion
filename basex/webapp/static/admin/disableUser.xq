xquery version'3.0';
declare option output:method "html";
declare variable $user external := "NN" ;

let $db:=collection('account')
  return
(: Bloquear usuario :)
replace value of node $db/account[user=$user]/enable with 'false'




