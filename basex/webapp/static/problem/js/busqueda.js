function searchIt(){
	var url = "/rest/";
	var option = document.getElementsByName("SelectOptionForSearch")[0].value;
	var txt = document.getElementsByName("searchTxt")[0].value;
	
	if(option === "H1"){
		url = url+"?run=/problem/buscar-problema.xq";
	}else if(option === "H2"){
		url = url+"?run=/problem/buscar-solucion.xq";
	}else{
		document.getElementsByName("divNotify")[0].innerHTML = "selecciona alguna opcion";
		document.getElementsByName("divNotify")[0].style.display = "block";
	}
	if(txt == ""){
		document.getElementsByName("divNotify")[0].innerHTML = "ingresa algun titulo";
		document.getElementsByName("divNotify")[0].style.display = "block";
		return;
	}else{
		url = url + "&search=" + txt;
		window.location = url;
		
	}	
}