let isShowed = false
let ammoDisabled = true
let colors = {
	'info': '#3377a4',
	'success': 'green',
	'danger': '#592124'
}

function showAlert (text, time, color) {
	let selector = $(`
	<div class="item item-alert">
		<div class="bar" style="background-color: ${colors[color]}"></div>
		<p class="alert-text text" style="font-family: 'Roboto', sans-serif;">${text}</p>
	</div>
			`).appendTo('#alerts')
	selector.animate({
		marginRight: 0,
		opacity: 1
	}, 600, () => {
		selector.find('.bar').animate({
			width: "100%",
		}, time ? time : 2000, "linear",
			() => {
				selector.fadeOut(600, () => {
					selector.remove();
				})
			});
	})
}

$(function () {
	window.addEventListener('message', function (event) {
		switch (event.data.action) {
			case 'setJob':
				$('.job-text').text(event.data.data)
				break
			case 'setVoice':
				

				if (event.data.voice == true) {

					$('#mic').css('opacity', '1.0')
				}
			
			else
				
			{
				if (event.data.voice == false) {
						
						$('#mic').css('opacity', '0')
				}
				}
			case 'setRadio':
				
				if (event.data.radio == true) {

					$('#radio').css('opacity', '1.0')
					
				}else
				
				{
					if (event.data.radio == false) {

						$('#radio').css('opacity', '0.0')
					}
				}
			case 'setJob2':
				if (event.data.data != "hide") {
					$('.job-text2').text(event.data.data)
					$('.item-job2').css('display', 'inline-block')
					break
				}
			case 'setMoney':
				$('#cash').text('$ ' + event.data.cash)
				$('#bank').text('$ ' + event.data.bank)
				if (typeof event.data.black_money !== 'undefined') {
					$('#black_money_item').show()
					$('#black_money').text('$ ' + event.data.black_money)
				} else {
					$('#black_money_item').fadeOut()
				}
				if (typeof event.data.society !== 'undefined') {
					$('#society_item').fadeIn()
					$('#society').text('$ ' + event.data.society)
				} else {
					$('#society_item').hide()
				}
				break
			case 'setAmmo':
				$('#ammoBox').show()
				$('#ammoBox-text').text(event.data.data)
				break
			case 'hideAmmobox':
				$('#ammoBox').fadeOut()
				break
			case 'initGUI':
				if (!event.data.data.enableAmmo)
					$('#ammoBox').fadeOut()
				if (event.data.data.whiteMode)
					$('#main').removeClass('dark')
				if (event.data.data.colorInvert)
					$('img').css('filter', 'unset')
				break
			case 'showAlert':
				showAlert(event.data.message, event.data.time, event.data.color)
				break
			case 'disableHud':
				event.data.data ? $('body').fadeOut(300) : $('body').fadeIn(1000)
				break
		}
	})
})