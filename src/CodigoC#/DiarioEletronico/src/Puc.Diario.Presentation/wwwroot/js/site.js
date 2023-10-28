// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.



$(document).ready(function () {
	$('#txtAno').css('color', '#c6c6c6');

	if (window.select2LanguageCustomNoResult && window.select2LanguageCustomMaximunSelected) {
		$.fn.select2.defaults.set('language', {
			noResults: function () {
				return window.select2LanguageCustomNoResult;
			},
			maximumSelected: function () {
				return window.select2LanguageCustomMaximunSelected;
			},
		});
	}

	$('.select2-single-default').select2({
		placeholder: '',
		minimumResultsForSearch: -1,
		allowClear: false,
	});

	$('.select2-multiple-application_id').select2({
		multiple: true
	});

	$('.select2-single').select2({
		placeholder: '',
		containerCssClass: 'select-sm',
		minimumResultsForSearch: -1,
		allowClear: true,
	});

	$('.select2-multiple').select2({
		placeholder: '',
		containerCssClass: 'select-sm',
		maximumSelectionLength: -1,
	});

	$('.select2-single-multiple').select2({
		placeholder: '',
		containerCssClass: 'select-sm',
		maximumSelectionLength: 1,
	});

	$('.select2-single-multiple.custom-location').select2({
		placeholder: '',
		containerCssClass: 'select-sm',
		maximumSelectionLength: 1,
		templateResult: optCustomLocationState,
	});

	$('.select2-multiple.custom-location').select2({
		placeholder: '',
		containerCssClass: 'select-sm',
		maximumSelectionLength: -1,
		templateResult: optCustomLocationState,
	});

	$('.select2-single-multiple.custom-site').select2({
		placeholder: '',
		containerCssClass: 'select-sm',
		maximumSelectionLength: 1,
		templateResult: optCustomSiteState,
	});

	$('.select2-multiple.custom-site').select2({
		placeholder: '',
		containerCssClass: 'select-sm',
		maximumSelectionLength: -1,
		templateResult: optCustomSiteState,
	});

	$('.select2-multiple.custom-color').select2({
		placeholder: '',
		containerCssClass: 'select-sm',
		maximumSelectionLength: -1,
		templateResult: optCustomColorState,
	});

	$('.select2-multiple.custom-owner').select2({
		placeholder: '',
		containerCssClass: 'select-sm',
		maximumSelectionLength: -1,
		templateResult: optCustomOwnerState,
	});

	$('.select2-single-multiple.custom-owner').select2({
		placeholder: '',
		containerCssClass: 'select-sm',
		maximumSelectionLength: -1,
		templateResult: optCustomOwnerState,
	});

	$('.select2').each(function () {
		if (IsMobile()) {
			$(this).addClass('no-search');
		}
	});

	// intercepta a abertura e habilita ou n�o a pesquisa 
	// a quantidade de REGISTROS que habilita ou n�o a pesquisa
	// n�o d� para ser dynamico, ter� que ficar fixado
	$('select').on('select2:opening', function (e) {
		const totalOptions = $(e.target).find("option").length;
		if (IsMobile() && totalOptions < 100) {
			$(e.target.parentElement).find(".select2").blur();
			$(e.target.parentElement).find(".select2").addClass("no-search");
		} else {
			$(e.target.parentElement).find(".select2").removeClass("no-search");
			$(e.target.parentElement).find(".select2").focus();
		}
	});
});