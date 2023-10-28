(function($) {

	"use strict";

	var fullHeight = function() {

		$('.js-fullheight').css('height', $(window).height());
		$(window).resize(function(){
			$('.js-fullheight').css('height', $(window).height());
		});

	};
	fullHeight();

	$('#sidebarCollapse').on('click', function () {
      $('#sidebar').toggleClass('active');
  });

})(jQuery);

function showBadgesNotas(idNota) {
	var badge = "";
	if (idNota >= 12 && idNota <= 15) {
		badge = "badge-warning";
	} else if (idNota > 15) {
		badge = "badge-success";
	} else if (idNota < 12) {
		badge = "badge-danger";
	}

	return badge
}

function CloseModal() {
    $('#registry-mainregister-modal').modal('hide');
}

function CloseModalPopup() {
    $('#mod-registro-popup').modal('hide');
}


function ShowModalLoading() {
    $('.modalLoading').modal('show');

}

function HideModalLoading() {
    setTimeout(function () {
        $('.modalLoading').modal('hide');
    }, 800);

}

function UpdatePage() {
    console.log('Updated');
    ShowModalLoading();
    parent.location.reload();
}

function UpdateMainContent() {
    console.log('Updated');
    ShowModalLoading();
    location.reload();
}

function OpenDynamicModal(modalURL, modalData, modalId, timeout) {

    /*Optional Paramters*/
    if (timeout === undefined) {
        timeout = 0;
    }

    ShowModalLoading();
    $(modalId).modal('hide');
    setTimeout(function () {
        $.ajax({
            method: 'post',
            cache: false,
            url: modalURL,
            data: modalData,
            success: function (modalContent) {
                HideModalLoading();

                $(modalId).find('#modal-content').html(modalContent);
                if (modalContent.indexOf('<div') >= 0)
                    $(modalId).modal('show');
                else
                    $(modalId).find('#modal-content').html('');
            },
            error: function () {
                HideModalLoading();
            }
        }).done(function () {
            HideModalLoading();
        });
        HideModalLoading();
    }, timeout);
}


function converterValor(number) {
    var words = ["primeiro", "segundo", "terceiro", "quarto", "quinto", "sexto", "setimo", "oitavo", "nono"];
    if (number >= 1 && number <= words.length) {
        return words[number - 1];
    }
    return "";
}

function updateDropdownAno(campoNivel, campoAno, anoSelecionado) {
    var nivelDropdown = document.getElementById(campoNivel);
    var anoDropdown = document.getElementById(campoAno);

    var nivelSelecionado = (nivelDropdown.value != null) ? nivelDropdown.value : "";
    anoDropdown.innerHTML = "";

    if (nivelSelecionado === "em") {
        for (var i = 1; i <= 3; i++) {
            var option = document.createElement("option");
            option.text = i + "° Ano";
            if (option.text == anoSelecionado) {
                option.selected = true;
            }
            option.value = converterValor(i);
            anoDropdown.removeAttribute("disabled", "disabled");
            anoDropdown.add(option);
        }
    }
    else if (nivelSelecionado === "ef") {
        for (var i = 1; i <= 9; i++) {
            var option = document.createElement("option");
            option.text = i + "° Ano";
            option.value = converterValor(i);
            if (option.text == anoSelecionado) {
                option.selected = true;
            }
            anoDropdown.removeAttribute("disabled", "disabled");
            anoDropdown.add(option);
        }
    } else {
        var option = document.createElement("option");
        option.text = "Selecione...";
        option.value = "";
        anoDropdown.setAttribute("disabled", "disabled");
        anoDropdown.add(option);
    }
}
