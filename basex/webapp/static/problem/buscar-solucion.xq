xquery version "1.0" encoding "utf-8";
declare option output:method "html";
declare option output:version "5.0";
declare variable $search as xs:string+ external;
let $db := collection("problem")
let $solution-info := $db/problem/solution
return
<html>
  <head>
    <title>Resultados de la Busqueda</title>
    <script type = "text/javascript" src = "/static/problem/js/funciones.js"></script> 
    <script type = "text/javascript" src = "/static/problem/js/busqueda.js"></script>
    <meta http-equiv="Refresh" content="url=?run=/problem/buscar-problema.xq"></meta>
    <meta http-equiv="Refresh" content="url=?run=/problem/buscar-solucion.xq"></meta>
    <meta http-equiv="Refresh" content="url=?run=/problem/listar-problemas.xq"></meta>
    <meta http-equiv="Refresh" content="url=?run=/problem/home.xq"></meta>
  </head>
  <body>
    <header>
    <div><a href="?run=/problem/home.xq">Ir al home</a></div>
    <a href="/static/auth/login.xml">Iniciar Sesión</a> 
    <a href="/static/auth/manage-account.xml">Registrarse</a>
    <h1>Solución</h1>
     
    </header>
    <nav>
      <div><a href="?run=/problem/listar-problemas.xq">Ver todos los problemas</a></div>
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
        for $solution in $solution-info where $solution/title contains text {$search} any
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
                   <br></br>
                   <h2>Comentarios</h2>
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
    </arcticle>
    </body>
</html>