xquery version "1.0" encoding "utf-8";
declare option output:method "html";
declare option output:version "5.0";
let $db := collection("problem")
let $problem-info := $db/problem
return
<html>
  <head>
    <title>Lista de Problemas</title>
    <script type = "text/javascript" src = "/static/problem/js/funciones.js"></script>
    <script type = "text/javascript" src = "/static/problem/js/busqueda.js"></script>
    <meta http-equiv="Refresh" content="url=?run=/problem/buscar-problema.xq"></meta>
    <meta http-equiv="Refresh" content="url=?run=/problem/buscar-solucion.xq"></meta>
    <meta http-equiv="Refresh" content="url=?run=/problem/home.xq"></meta>
  </head>
  <body>  
    
    <header>
    <div><a href="?run=/problem/home.xq">Ir al home</a></div>
    <a href="/static/auth/login.xml">Iniciar Sesión</a> 
    <a href="/static/auth/manage-account.xml">Registrarse</a> 
    <h1>PROBLEMAS</h1>
    
    </header>
    <nav>
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
    
    for $iterator in $problem-info   
       order by $iterator/title 
       let $reviews := $iterator/review
       let $cats := $iterator/category
       let $solution := $iterator/solution
       let $sol-reviews := $solution/review
       let $id := $iterator/id/text()
       return <div id ="{$id}" class = "Problem" onHover ="" onClick = "">
                 <br></br>
                 {string("Problema compartido por: ")}<b>{$iterator/autor/name/text()}</b>
           <input type = "button" class = "btnToggle" id = "{concat('verReviews', $id)}" value = "Ver comentarios" onClick = "verOcultar('{concat('reviews',$id)}', '{concat('verReviews', $id)}')"/>
           <input type = "button" class = "btnToggle" value = "Ver solucion" id = "{concat('verSolucion', $id)}" onCLick = "verOcultar('{concat('solucion', $id)}', '{concat('verSolucion', $id)}')"/>
           <div class = "Title" ><b>{$iterator/title/text()}</b></div>
           <div class = "Description">{$iterator/description/text()}</div>           
           {         
             for $it in $cats
               return <div class = "Category">{$it/text()}</div>
           }
           <div class = "Ranking">{string("Puntuacion: ")}<b>{avg($iterator/review/ranking/text())}</b></div>           
           <div class = "Reviews" id = "{concat('reviews',$id)}" style = "display: none;">{string("Comentarios: ")}
           {        
             for $it in $reviews
               return <div class = "Review">
                   <div class = "User-Review"><b>{$it/user/text()}</b>{string(" dijo:")}</div>
                   <div class = "Comment-Review">{$it/comment/text()}</div>
                   <div class = "Ranking">{string("Le dio una puntuacion de: ")}<b>{$it/ranking/text()}</b></div>
                 </div>
           }</div>           
           <div class = "Solution" id = "{concat('solucion',$id)}" style = "display: none;">{string("Solucion ")}
             <div class = "Author"><b>{$solution/autor}</b>{string(" compartio esta solucion: ")}</div>
             <div class = "Title"><b>{$solution/title/text()}</b></div>
             <div class = "Description">{$solution/description/text()}</div>
             <div class = "Ranking">{string("Puntuacion: ")}<b>{avg($solution/review/ranking/text())}</b></div>
             {
               for $it in $sol-reviews
                 return <div class = "Review">
                     <div class = "User-Review"><b>{$it/user/text()}</b>{string(" dijo:")}</div>
                     <div class = "Comment-Review">{$it/comment/text()}</div>
                     <div class = "Ranking">{string("Le dio una puntuacion de: ")}<b>{$it/ranking/text()}</b></div>
                   </div>
             }</div>
             
         </div>       
  }
    </article>
  </body>
</html>