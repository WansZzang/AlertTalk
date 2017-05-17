
(function ($) {

    /**
	Global object which lives on every page.
	@class $.Tooltip
	@constructor
	**/
    $.Tooltip= function () {

		var $container = $('.incframe');
		var $target = $('[data-role]');
		var $button = [];
		var $input = [];
		var tooltip = [];
		var objClass = [];
		var direction = [];
		var title = [];
		var timer = null;
		var text ='';

		var safari = /Safari/.test(navigator.userAgent) && /Apple Computer/.test(navigator.vendor);

        /**
		@function init
		**/
        function init() {

			setup();
			bindEvents();

		}

		function setup(){
			[].forEach.call($target, function(self, i){
				objClass[i] = $(self).attr('data-role');
				direction[i] = $(self).attr('data-direction');
				title[i] = $(self).attr('title') ? $(self).attr('title') : null;
				if(title[i]){
					tooltip[i] = createTooltip(title[i], objClass[i]);
					tooltip[i].insertAfter($(self));
					$(self).attr('title','');
				}else{
					tooltip[i] = $(self).next('.'+objClass[i]);
				}

				tooltip[i].addClass(direction[i]);
			});
		}

		function createTooltip(title, objClass){
			var tooltipStr;

			tooltipStr = '<div class="'+objClass+'" role="'+objClass+'">';
			tooltipStr += '<div class="arrow"></div>';
			tooltipStr += '<div class="inner">' + title + '</div>';
			tooltipStr += '</div>';

			return $(tooltipStr);
		}

		function bindEvents(element, idx){

			$input[idx] = $(element).filter('[type="text"]');

			$('[data-role="popover"]').on('mousedown', function(e){
				var evnt = e;
				var self = this;

				//clearTimeout(timer);

				$(self).next('.popover').show('fast', function(){
					if(!safari){
						$(this)[0].style.setProperty("-webkit-transition", "all .3s");
						$(this)[0].style.setProperty("transition", "all .3s");
					}
					$(self).addClass('on');
					$(this).addClass('in');
					showTooltip(self);
				});
			});

			$(document).on('mouseup', function(e){
				var src = e.target || e.srcElement,
					$el, $bt;

				$el = $('.popover.in');
				$bt = $el.prev()

				if (!$el.is(e.target) && !$bt.is(e.target) && $el.has(e.target).length === 0){
					$el.removeClass('in');
					if($bt.hasClass('on')) $bt.removeClass('on');
					hideTooltip($bt[0]);
				}
			});

			$('[data-role="tooltip"]').on('mouseenter', function(e){
				var evnt = e;
				var self = this;

				//clearTimeout(timer);

				$(self).next('.tooltip').show('fast', function(){
					if(!safari){
						$(this)[0].style.setProperty("-webkit-transition", "all .3s");
						$(this)[0].style.setProperty("transition", "all .3s");
					}
					$(this).addClass('in');
					showTooltip(self);
				});
			});

			$('[data-role="tooltip"]').on('mouseleave', function(e){
				var evnt = e;
				var self = this;

				if (self == e.currentTarget){
					$(self).next('.tooltip').removeClass('in');
					hideTooltip(self);
				}
			});

			$(window).on('resize', function(){
				$('[data-role="popover"]').each(function(){
					if($(this).hasClass('on')) $(this).trigger('mousedown');
				});
			});

		}

		function showTooltip(context){
			var idx = $target.index(context);
			var $self = $(context);
			//var marginLeft = parseInt($self.css('margin-left'));

			$(tooltip[idx]).css({'opacity':'1'});

			var coords = getPosition(idx, $self);
			$(tooltip[idx]).css({ 'left' : coords.left, 'top' : coords.top});

			if($self.attr('data-effect')!=null){
				if($(tooltip[idx]).hasClass('in')){
					setTimeout(function(){
						$(tooltip[idx]).removeClass('in');
						hideTooltip($self[0]);
					},3000);
				}
			}
		}

		function getPosition(num, $elem){

			var idx = num,
				$self = $elem,
				tooltipWidth = $(tooltip[idx])[0].getBoundingClientRect().width,
				tooltipHeight = $(tooltip[idx])[0].getBoundingClientRect().height,
				xpos = $self.position().left,
				ypos = $self.position().top,
				coords = {};

			if(direction[idx] == 'top' || direction[idx] == 'bottom'){

				var selfWidth = $self[0].offsetWidth/2;
				var selfHeight = $self[0].offsetHeight;
				tooltipWidth = (tooltipWidth/2)-selfWidth;

				coords.left = xpos-tooltipWidth;
				coords.top = (direction[idx]=='top') ? ypos-tooltipHeight : ypos+selfHeight;

			}else if(direction[idx] == 'top-right' || direction[idx] == 'bottom-right'){

				var width = tooltipWidth - $self[0].getBoundingClientRect().width;
				var selfHeight = $self[0].offsetHeight;

				coords.left = xpos;
				coords.top = (direction[idx]=='top-right') ? ypos-tooltipHeight : ypos+selfHeight;

			}else if(direction[idx] == 'top-left' || direction[idx] == 'bottom-left'){

				var width = tooltipWidth - $self[0].getBoundingClientRect().width;
				var selfHeight = $self[0].offsetHeight;

				coords.left = (xpos<width) ? xpos-10 : xpos-width;
				coords.top = (direction[idx]=='top-left') ? ypos-tooltipHeight : ypos+selfHeight;

				if(xpos<width){
					$(tooltip[idx]).removeClass('top-left').addClass('top-right');
				}else{
					$(tooltip[idx]).removeClass('top-right').addClass('top-left');
				}

			}else if(direction[idx] == 'left' || direction[idx] == 'right'){

				var selfWidth = $self[0].offsetWidth;
				var selfHeight = $self[0].offsetHeight;
				if(tooltipHeight<selfHeight){
					selfHeight = $self[0].offsetHeight/2;
					tooltipHeight = tooltipHeight/2;
				}

				coords.left = (direction[idx]=='left') ? xpos - (tooltipWidth+10) : xpos + (selfWidth+10);
				coords.top = (ypos+selfHeight)-tooltipHeight;
			}

			return coords;
		}

		function hideTooltip(context){
			if(context == undefined) return false;

			var idx = $target.index(context);
			var $self = $(context);

			$(tooltip[idx]).css({'opacity':'0'});

			timer = setTimeout(function(){
				$(tooltip[idx]).hide('fast', function(){
					$(tooltip[idx]).attr('style','');
				});
			}, 300);

		}

		return {
			init : init
		};

	};

}(jQuery));

$(function () {
	new $.Tooltip().init();
});

