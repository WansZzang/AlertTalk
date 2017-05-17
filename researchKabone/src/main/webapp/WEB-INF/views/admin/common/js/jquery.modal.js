
if (jQuery)(function($) {
		$.extend($.fn, {
			modalpop: function(opt){
				opt = opt || {} ;
				var dOpt = {
					css : {
						opacity:"0.7",
						backgroundColor:"#000"}
				}

				$.extend(dOpt, opt);


				var $layer = $(this)._layerWrap();
				$layer.layerMask(dOpt.css);

				$layer.data("data-before", $(this));

				var href = $(this).attr('href');
				$.get(href, function(data){
					$layer.layerData($(data).find("div:eq(0)").html());
				});


				$(window).bind('resize.modal',function(e,opt){
					var dOpt = { isAni : true };
					var w = $(window).width();
					var h = $(window).height();
					var layerContainerWidth = $("#layerContainer").height();
					var layerContainerHeight = $("#layerContainer").height();
					$.extend(dOpt,opt);

					$layer.width(w).height(h);
					$("#dim").width(w).height(h);

					var t = "";
					var l = 0;
					// 반응형
					if(w <= 768){
						if(h <= layerContainerHeight){
							t = 0;
							h = $(window).height();
						}else{
							t = (h-layerContainerHeight)/2;
							h = 'auto';
						}
						$("#layerContainer").stop().css({
							'display' : 'block',
							top:t,
							left:0,
							height : h
						});
					}else{
						t = (h-layerContainerHeight)/2;
						$("#layerContainer").stop().css({
							'display' : 'inline-block',
							top:t,
							left:l
						});
					}
				});
			}
			,_layerWrap: function(opt){
				opt = opt || {} ;
				if( $("#layerWrap").size() == 0 ){
					var css = {
						opacity:0,
						zIndex:"9999",
						position:"fixed",
						textAlign:"center",
						width:$(window).width(),
						height:$(window).height(),
						top:"0",
						left:"0px"};


					$.extend(css, opt);
					$("body").prepend($("<div id='layerWrap'/>").css(css));

					$("#layerWrap").bind('close',function(){
						$("html, body").css({'overflow':"auto"});

						$("#layerWrap").stop().animate({opacity:0},500,function(){
							$(this).hide();
							$("#layerWrap").data('data-before').focus();
						});
					});

					$(document).unbind('keyup.layerWrap_close');
					$(document).bind('keyup.layerWrap_close',function(e){
						if( e.keyCode == 27 ){
							$("#layerWrap").trigger('close');
						}
					});
					$("#layerWrap").delegate("a.close", "click" ,function(e){
						e.preventDefault();
						$("#layerWrap").trigger('close');
					});

				}

				$("html, body").css({overflow:"hidden"});
				return $("#layerWrap").show().stop().animate({opacity:1},500);
			}
			,layerMask: function(opt){
				opt = opt || {} ;
				if( $("#dim").size() == 0 ){
					var css = {
						zIndex:"10",
						position:"absolute",
						width:$(window).width(),
						height:$(window).height(),
						top:"0px",
						left:"0px",
						opacity:"0.5",
						backgroundColor:"#000"} ;

					$.extend(css, opt);
					$(this)._layerWrap().append($("<div id='dim'/>").css(css));

					$("#dim").bind('click',function(e){
						e.preventDefault();
						$("#layerWrap").trigger('');//close
					});
				}

				return $("#dim") ;
			}
			,layerData: function(data){
				if( $("#layerContainer").size() == 0 ){
					var css = {
						zIndex:"50",
						position:"relative",
						// width:'984px',
						// height:"490px",
						width:$("#layerContainer").outerWidth(),
						height:$("#layerContainer").outerHeight(),
						textAlign:"center",
						display:"inline-block",
						backgroundColor:"#fff",
						opacity:"1"} ;
					var w = $(window).width();
					var h = $(window).height();
					var layerContainerHeight = $("#layerContainer").height();
					var layerContainerWidth = $("#layerContainer").width();

					$(this)._layerWrap().prepend($("<div id='layerContainer' class='item-cont'/>").attr('tabindex','0').css(css));
					$(this)._layerWrap().append('<div class="end-cont" tabindex=0></div>');
					$(this)._layerWrap().find(".end-cont").bind("focus", function(){
						$("#layerContainer").focus();
					});

					/* 구문 추가 */
					var t = "";
					if(w <= 768){
						if(h <= layerContainerHeight){
							t = 0;
						}else{
							t = (h-layerContainerHeight)/2;
						}
					}else{
						t = (h-layerContainerHeight)/2;
					}
					var l = (w-layerContainerWidth)/2;
					$("#layerContainer").css({top:t,left:l});
					/* //구문 추가 */
				}

				var $div = $("<div />").html(data);
				$("#layerContainer").html($div);

				$(window).trigger('resize.modal',{isAni:false});
				return $("#layerContainer").focus() ;
			}
		});
	})(jQuery) ;
