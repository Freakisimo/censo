$(document).on("ready", inicio);

function menu () {
	// body...
	$("#menu li").on("click", submenu);
	var menu = datos.currentTarget.id;
	alert(menu);
}
function submenu(datos)
{
	var menu = datos.currentTarget.id;

	alert(menu);

	var ocultarCSS = 
	{ 
		overflow: "hidden",
	};
	var mostrarCSS = 
	{ 
		overflow: "visible",
	};

	$('article').each(function(index, value){
    	if ($(this).attr('id')=menu) {
    		$(this).css(mostrarCSS);
    	}else{
    		$(this).css(ocultarCSS);
    		}
    	};
	});
}