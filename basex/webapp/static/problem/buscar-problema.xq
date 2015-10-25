xquery version "1.0" encoding "utf-8";
declare option output:method "html";
declare option output:version "5.0";
declare variable $search as xs:string+ external;
let $db := collection("problem")
let $problem-info := $db/problem
return
<html>
  <head>
    <title>Resultados de la Busqueda</title>
    <script type = "text/javascript" src = "/static/problem/js/funciones.js"></script> 
    <script type = "text/javascript" src = "/static/problem/js/busqueda.js"></script>
    <meta http-equiv="Refresh" content="url=?run=buscar-problema.xq"></meta>
    <meta http-equiv="Refresh" content="url=?run=buscar-solucion.xq"></meta>
    <meta http-equiv="Refresh" content="url=?run=listar-problemas.xq"></meta>
    <meta http-equiv="Refresh" content="url=?run=home.xq"></meta>
  </head>
  <body>
    <header>
    <div><a href="?run=home.xq">Ir al home</a></div>
    <h1>Problema</h1>
    <a href="/static/auth/login.xml">Iniciar Sesión</a> 
    <a href="/static/auth/manage-account.xml">Registrarse</a> 
    </header>
    <nav>
      <div><a href="?run=listar-problemas.xq">Ver todos los problemas</a></div>
      <form name ="formFinder" method = "GET">
        <select name = "SelectOptionForSearch">
          <option value = "H1" seleced = "selected">Buscar problemas</option>
          <option value = "H2">Buscar soluciones</option>
        </select>      
        <div name = "divNotify" style = "display: none;"></div>
        <input type = "text" name = "searchTxt" placeholder = "Busca por el nombre"></input>
        <button class = "btnToggle" type = "button" onclick = "searchIt()">search</button>
      </form>
    </nav>
    <div>{string("Resultados de la busqueda para: ")}<b>{string($search)}</b></div>
    <arcticle>
       {
         let $result := for $it1 in $problem-info where $it1/title contains text {$search} any 
                                      let $solution-info := $it1/solution
                                      let $cats := $it1/category
                                      let $id := $it1/id
                                      let $reviews := $it1/review
                                      return <div id ="{$id}" class = "Problem" onHover ="" onClick = "">
                                               <br></br>
                                               {string("Problema compartido por: ")}<b>{$it1/autor/name/text()}</b>
                                               <div class = "Title"><b>{$it1/title/text()}</b></div>
                                               <div class = "Description">{$it1/description/text()}</div>
                                               <div class = "Ranking">{string("Puntuacion: ")}
                                                 <b>{avg($it1/review/ranking/text())}</b>
                                               </div>
                                                {         
                                                   for $it in $cats
                                                       return <div class = "Category">{$it/text()}</div>
                                                }                                                          
                                               <div class = "Reviews" id = "{concat('reviews',$id)}">
                                                 <br></br>
                                                 <h2>{string("Comentarios: ")}</h2>
                                                 {        
                                                   for $it in $reviews
                                                     return <div class = "Review">
                                                               <div class = "User-Review"><b>
                                                                 {$it/user/text()}</b>{string(" dijo:")}
                                                               </div>
                                                               <div class = "Comment-Review">{$it/comment/text()}</div>
                                                               <div class = "Ranking">{string("Le dio una puntuacion de: ")}
                                                                 <b>{$it/ranking/text()}</b>
                                                               </div>
                                                             </div>
                                                  }
                                               </div>
                                               <br></br>
                                               <h2>Solucion</h2>
                                                 { 
        for $solution in $solution-info where $solution/title = $search
          let $sol-reviews := $solution/review
          return <div class = "Solution">
                   <div class = "Author">
                      <b>{$solution/autor/text()}</b>{string(" compartio esta solucion: ")}
                   </div>
                   <div class = "Title"><b>{$solution/title/text()}</b></div>
                   <div class = "Description">{$solution/description/text()}</div>
                   <div class = "Ranking">
                      {string("Puntuacion: ")}<b>{avg($solution/review/ranking/text())}</b>
                   </div>
                     {
                       for $it in $sol-reviews
                         return <div class = "Review">
                                   <div class = "User-Review">
                                      <b>{$it/user/text()}</b>{string(" dijo:")}
                                   </div>
                                   <div class = "Comment-Review">{$it/comment/text()}</div>
                                   <div class = "Ranking">
                                     {string("Le dio una puntuacion de: ")}<b>{$solution/review/ranking/text()}</b>
                                   </div>
                               </div>
                     }
                   </div>
                   
      }                                              
                                             </div>
       
             for $it1 at $pos in $result where $pos < 2
               return $it1
        
           
       }
    </arcticle>
  </body>
</html>