<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sform"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title><decorator:title default="▒ Spoon CMS ▒" /></title>
	
	<meta charset="utf-8">
	<!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="" />
	<meta name="author" content="" />

	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
	<meta http-equiv="imagetoolbar" content="no" />
	<meta http-equiv='Cache-Control' ConTENT='no-cache'>
	<meta http-equiv='Pragma' ConTENT='no-cache'>
	<meta http-equiv="Expire" ConTENT="-1">
	
	<link rel="stylesheet" href="/admin/common/css/default.css">
	<link rel="stylesheet" href="/admin/common/css/common.css">
	<link rel="stylesheet" href="/admin/common/css/bootstrap-datepicker.css">
	
	<style>
		.snb {
			display : none;
		}
	</style>
	<script type="text/javascript" src="/admin/common/js/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="/admin/common/js/jquery.validate.js"></script>
	<script type="text/javascript" src="/admin/common/js/ui.common.js"></script>
	<script type="text/javascript" src="/admin/common/js/jquery.placeholder.js"></script>
	<script type="text/javascript" src="/admin/common/js/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="/admin/common/js/customCommon.js"></script>
	
	<script type="text/javascript" src="/admin/common/js/util.js"></script>
	
	<!-- 20161024 ycyu add > 드래그앤드랍 -->
	<!-- <script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script> -->
	<script type="text/javascript" src="/admin/common/js/jquery.tablednd.js"></script>
	
	
	<script>
		/*
		jQuery.validator.setDefaults({
			onkeyup:false,
			onclick:false,
			onfocusout:false,
			showErrors:function(errorMap, errorList){
				if(this.numberOfInvalids()) { 
					alert(errorList[0].message);
					 $(errorList[0].element).focus();
	            }
			}
		});
		*/
	
		$(function(){
			$(document).on('click', 'header > ul.nav > li' , function(){
				var _menuId = $(this).attr("class");
				var _url = $(this).children().attr('href');
				console.log(">>>url:" + _url);
				
				if ( _url == '#' ){
					$('header > ul.nav > li').removeClass("active");
					$(this).addClass("active");
					$('#side > div.snb').hide();
					$('#side > div.' + _menuId).show();
					$('#side > div.' + _menuId + " > ul > li:nth-child(1)").addClass("active");
				}else{
					console.log(">>>2");
				}
			});
			
		});
		
		$(document).ready(function(){
			var _location = location.pathname;
			var _referer = document.referrer;
			
			var _urlArr = _location.split('/');
			
			//top menu
			$('header > ul.nav > li').removeClass("active");
			$('header > ul.nav > li.' + _urlArr[1]).addClass('active');
			
			//side menu
			$('div.snb').hide();
			$('#side > div.' + _urlArr[1]).show();
			$('ul.side-nav > li').removeClass("active");
			$('ul.side-nav > li > ul > li').removeClass("active");
			
			$('ul.side-nav > li > a[href*="' + _location + '"]').parent().parent().addClass("active");
			$('ul.side-nav > li > a[href*="' + _location + '"]').parent().addClass("active");
			
			$('ul.side-nav > li > ul > li > a[href*="' + _location + '"]').parent().parent().parent().addClass("active");
			$('ul.side-nav > li > ul > li > a[href*="' + _location + '"]').parent().addClass("active");
			
			//body에서 추출
			//var _bodyTag = $(document.body).
		});
		
		function setSearchTermType(val){
			//alert(val);
			
			$(".hasDatepicker").attr('disabled',false);		//달력 enable
			
			if(val == '1'){			//전체기간
				$("#searchStartDt").val('');
				$("#searchEndDt").val('');
				$(".hasDatepicker").attr('disabled',true);	//달력 disable			
			}else if(val == '2'){	//어제	
				fnGetTargetDay( -1, $('#searchStartDt'), $('#searchEndDt'));
			}else if(val == '3'){	//오늘
				fnGetTargetDay( 0, $('#searchStartDt'), $('#searchEndDt'));
			}else if(val == '4'){	//1주일
				fnGetCalDate( -7, $('#searchStartDt'), $('#searchEndDt'));
			}else if(val == '5'){	//1개월
				fnGetCalMonth( -1, $('#searchStartDt'), $('#searchEndDt'));
			}else if(val == '6'){	//3개월
				fnGetCalMonth( -3, $('#searchStartDt'), $('#searchEndDt'));
			}else if(val == '7'){	//6개월
				fnGetCalMonth( -6, $('#searchStartDt'), $('#searchEndDt'));
			}else if(val == '8'){	//1년
				fnGetCalMonth( -12, $('#searchStartDt'), $('#searchEndDt'));
			}else if(val == '9'){	//직접입력
				
			}
		}
	</script>
	<decorator:head/>
	
</head>
<body>
	<!-- header -->
	<page:applyDecorator name="topmenu" />
	<!-- //header -->
	
	<!-- Container -->
	<div id="container">
		
		<!-- side -->
		<page:applyDecorator name="leftmenu" />
		<!-- //side -->
		
		<!-- contents -->
		<section class="contents">
			<decorator:body/>
		</section>
		<!-- //content -->
		
	</div>
	<!-- //Container -->
	
</body>
</html>