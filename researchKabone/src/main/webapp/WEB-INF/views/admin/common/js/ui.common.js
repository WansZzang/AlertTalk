$(function(){
	// LNB
	$('.side-nav > li > a').on('click', function(){
		var $that = $(this);
		$that.parent('li').addClass('active').siblings('li').removeClass('active');
	});

	// 상세검색
	$('[data-role="popover"]').on('click', function(){
		var $that = $(this),
			$popCont = $that.next('[role="popover"]');
		if($that.is('.active')){
			$that.removeClass('active');
			$popCont.hide();
		}else{
			$that.addClass('active');
			$popCont.show();
		}

		// 검색하기
		$('.popover-close').on('click', function(){
			$that.removeClass('active');
			$popCont.hide();
		});
	});


	// datepicker
	$(".hasDatepicker").datepicker({
		format: "yyyy-mm-dd",
		language: "kr",
		autoclose: true,
		todayHighlight: true
	});

});


/**********************
	UI : Window Popup
***********************/
	// 함수명	: 팝업띄우기
	// 인자값	: newWindow(
	// 			a_str_windowURL,	// string	| URL
	// 			a_str_windowName,	// string	| 윈도우 이름
	// 			a_int_windowWidth,	// integer	| 윈도우 가로 사이즈
	// 			a_int_windowHeight,	// integer	| 윈도우 세로 사이즈
	// 			a_bool_scrollbars,	// boolean	| 스크롤바 유무
	// 			a_bool_resizable,	// boolean	| 리사이징 유무
	// 			a_bool_menubar,		// boolean	| 메뉴바 유무
	// 			a_bool_toolbar,		// boolean	| 툴바 유무
	// 			a_bool_addressbar,	// boolean	| 주소창 유무
	// 			a_bool_statusbar,	// boolean	| 상태표시바 유무
	// 			a_bool_fullscreen	// boolean	| 풀스크린 유무
	// 		)
	// 사용예	: <a href="popup.html" target="_blank" onclick="newWindow(this.href,'popup',810,400,0,0,0,0,0,0,0); return false;">

function newWindow(a_str_windowURL, a_str_windowName, a_int_windowWidth, a_int_windowHeight, a_bool_scrollbars, a_bool_resizable, a_bool_menubar, a_bool_toolbar, a_bool_addressbar, a_bool_statusbar, a_bool_fullscreen) {
	var int_windowLeft 			= (screen.width		- a_int_windowWidth) 	/ 2;
	var int_windowTop 			= (screen.height 	- a_int_windowHeight) 	/ 2;
	var str_windowProperties 	= "height=" 		+ a_int_windowHeight
								+ ",width=" 		+ a_int_windowWidth
								+ ",top=" 			+ int_windowTop
								+ ",left=" 			+ int_windowLeft
								+ ",scrollbars="	+ a_bool_scrollbars
								+ ",resizable=" 	+ a_bool_resizable
								+ ",menubar=" 		+ a_bool_menubar
								+ ",toolbar=" 		+ a_bool_toolbar
								+ ",location=" 		+ a_bool_addressbar
								+ ",statusbar=" 	+ a_bool_statusbar
								+ ",fullscreen=" 	+ a_bool_fullscreen + "";
	var obj_window 				= window.open(a_str_windowURL, a_str_windowName, str_windowProperties);
	if (parseInt(navigator.appVersion) >= 4) {
		obj_window.window.focus();
	}
}


function setFilename(id, obj){
	document.getElementById(id).value=obj.value.split('\\')[obj.value.split('\\').length-1]
}

/**
 * [imgView : img popup]
 */
var cnj_img_view = null;
function imgView(img){
	img_conf1= new Image();
	img_conf1.src=(img);
	cnjViewConf(img);
}

function cnjViewConf(img){
	if((img_conf1.width!=0)&&(img_conf1.height!=0)){
		cnjViewImg(img);
	} else {
		funzione="cnjViewConf('"+img+"')";
		intervallo=setTimeout(funzione,20);
	}
}

function cnjViewImg(img){
	if(cnj_img_view != null) {
		if(!cnj_img_view.closed) { cnj_img_view.close(); }
	}
	cnj_width=img_conf1.width;
	cnj_height=img_conf1.height;
	int_windowTop = (screen.height - cnj_height) / 2;
	int_windowLeft = (screen.width - cnj_width) / 2;
	str_img="width="+cnj_width+",height="+cnj_height + ",top=" +int_windowTop + ",left=" + int_windowLeft;
	cnj_img_view=window.open(img,"cnj_img_open",str_img);
	cnj_img_view.focus();
	return;
}


/**
 * [hideLayer : layer close]
 * @param  {[type]} self [click target]
 */
function hideLayer(self){
	var $self = $(self),
		$layerWrap = $self.parents('.modal-pop');
		$layerWrap.find('button.close').trigger('click');
}

/**
 * [showLayer : layer open]
 * @param  {[type]} self [click target]
 * @param  {[type]} obj  [terget layer]
 */
function showLayer(self, obj){
	var $self = $(self),
		$target = $('#' + obj),
		$layerInner = $target.find('.modal-cotainer'),
		layerAlignLeft = "";
		layerAlignTop = "";
		windowWidth = $(window).width(),
		windowHeight = $(window).height(),
		layerHeight = $layerInner.outerHeight();
		layerWidth = $layerInner.outerWidth();

	// 레이어중복 열림 방지
	if($self.parents(".modal-pop").length > 0){
		$self.parents(".modal-pop").find('.close').trigger('click');
	}

	// Dim
	$target
		.append('<div id="dim"></div>')
		.fadeIn(300);

	layerHeight = $layerInner.outerHeight();
	layerWidth = $layerInner.outerWidth();
	if(layerWidth > layerHeight){
		//alert('222 layerWidth='+layerWidth+', windowWidth='+windowWidth+ ', layerHeight='+layerHeight+', windowHeight='+windowHeight);
		
		if(layerHeight > windowHeight){
			$layerInner.height(windowHeight-10);
			layerHeight = windowHeight-10;
		}

		// 사이즈
		layerAlignLeft = $layerInner.outerWidth()/2;
		layerAlignTop = $layerInner.outerHeight()/2;
		
	}
	//20161031 ycyu add > 모바일에서 세로모드일 경우 처리
	else{
		//alert('layerWidth='+layerWidth+', windowWidth='+windowWidth+ ', layerHeight='+layerHeight+', windowHeight='+windowHeight);
		if(layerHeight > windowHeight){
			$layerInner.height(windowHeight-10);
			layerHeight = windowHeight-10;
		}

		// 사이즈
		layerAlignLeft = $layerInner.outerWidth()/2;
		layerAlignTop = $layerInner.outerHeight()+$layerInner.outerHeight()/10;
	}
	

	$layerInner.css({
		'margin-top' : -layerAlignTop,
		'margin-left' : -layerAlignLeft,

	})
	.attr('tabindex', '0')
	.focus();

	// 닫기
	$target.find("button.close").on('click', function(){
		$layerInner.removeAttr('tabindex');
		$target.fadeOut(300, function(){
			$target.find("#dim").remove();
		});
		$self.focus();
		$(this).off('click');
		$(window).off('resize orientationchange');
	});
}