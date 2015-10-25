xquery version "1.0" encoding "utf-8";
declare option output:method "html";
declare option output:version "5.0";
let $db := collection("problem")
let $problem-info := $db/problem
return
<html>
  <head>
    <title>Home</title>
    <meta http-equiv="Refresh" content="url=?run=/problem/listar-problemas.xq"></meta>
    <meta http-equiv="Refresh" content="url=?run=/problem/buscar-problema.xq"></meta>
    <meta http-equiv="Refresh" content="url=?run=/problem/buscar-solucion.xq"></meta>
    <script type = "text/javascript" src = "/static/problem/js/funciones.js"></script> 
    <script type = "text/javascript" src = "/static/problem/js/busqueda.js"></script>
    <script type = "text/javascript" src = "/static/problem/js/problema.js"></script>
  </head>
  <body>
    <a href="/static/auth/login.xml">Iniciar Sesión</a> 
    <a href="/static/auth/manage-account.xml">Registrarse</a> 
    <header><h1>HOME</h1>
   
    </header>
    <a href="/static/problem/editarProblema.xml">Crear nuevo problema</a> 
    <br/>
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
    <article>
    {
      let $result := for $better in $problem-info
                        let $ranking := avg($better/review/ranking/text())
                        order by $ranking descending
                        return $better  
      for $x at $pos in $result where $pos <= 3
        return <div class = "Problem" onclick = "showProblem('{$x/title/text()}')"><br></br>
                 {string("Problema compartido por: ")}<b>{$x/autor/name/text()}</b>                 
                 <div class = "Title"><b>{$x/title/text()}</b></div>
                 <div class = "Description">{$x/description/text()}</div>
                 <div class = "Ranking">{string("Puntuacion: ")}<b>{avg($x/review/ranking/text())}</b></div>
               </div>
    }
    </article>
  </body>
</html>