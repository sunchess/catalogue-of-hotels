$(document).ready(function(){

	$('input#title_').val("Введите название места");

	$('input#title_').focus(function(){

			var txtval = $('input#title_').val();
			if(txtval == 'Введите название места'){ $(this).val('');}

	});

	$('input#title_').focusout(function(){

			var txtval = $('input#title_').val();
			if(txtval == ""){ $('input#title_').val('Введите название места');}

	});

});

