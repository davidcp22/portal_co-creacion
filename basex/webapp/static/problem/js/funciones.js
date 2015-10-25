
function verOcultar(id, buttonId){
	var reviews = document.getElementById(id);
	var texto = document.getElementById(buttonId).value;
	if(reviews.style.display == "none"){
		document.getElementById(id).style.display = "block";
		if(texto === "Ver comentarios"){
			document.getElementById(buttonId).value = "Ocultar comentarios";
		}else if(texto === "Ver solucion"){
			document.getElementById(buttonId).value = "Ocultar solucion";
		}
	}else{
		document.getElementById(id).style.display = "none";
		if(texto === "Ocultar comentarios"){
			document.getElementById(buttonId).value = "Ver comentarios";
		}else if(texto === "Ocultar solucion"){
			document.getElementById(buttonId).value = "Ver solucion";
		}
	}
}


