/**
 * IE console error
 */
if(typeof console=="undefined"){var console={log:function(){},debug:function(){},info:function(){},warn:function(){},error:function(){}};}else{if(typeof console.log=='undefined'){console.log=function(e){};}if(typeof console.debug=='undefined'){console.debug=function(e){};}if(typeof console.info=='undefined'){console.info=function(e){};}if(typeof console.warn=='undefined'){console.warn=function(e){};}if(typeof console.error=='undefined'){console.error=function(e){};}};

/**
 * 좌우 공백 제거
 * @returns {string}
 */
String.prototype.trim = function () {
	return this.replace(/(^\s*)|(\s*$)|($\s*)/g, "");
};

/**
 * 왼쪽 공백없애는 함수
 * @returns {string}
 */
String.prototype.ltrim = function () {
	return this.replace(/^s*/g, "");
};

/**
 * 오른쪽 공백없애는 함수
 * @returns {string}
 */
String.prototype.rtrim = function () {
	return this.replace(/s*$/g, "");
};

/**
 * html 특수문자 변환
 * @returns {string}
 */
String.prototype.htmlChars = function () {
	var str = ((this.replace('"', '"')).replace("'", '`'));
	return (str.replace('<', '&lt;')).replace('>', '&gt;');
};

/**
 * html 특수문자 변환
 *
 * @returns {string}
 */
String.prototype.escapeHTML = function () {
	return this.replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "＂").replace(/'/g, "`");
};

/**
 * html tag 제거
 * @returns {string}
 */
String.prototype.removeHTML = function () {
	var objStrip = new RegExp();
	objStrip = /[<][^>]*[>]/gi;
	return this.replace(objStrip, "");
};

/**
 * TextArea개행문자 처리
 */
String.prototype.textAreaBrTag = function() {
    $result = "";
    $str = this.replace(/(\r\n|\n|\n\n)/gi,'[split]');
    $str = $str.replace(/\'/g,"''");
    $str = $str.split("[split]");
    $.each(
        $str,function(i){
            if($str[i]=="")
                $result +="&nbsp;</br>"+"\r\n";
            else
                $result +=$str[i]+"</br>"+"\r\n";
        });
    return 	$result;
};

/**
 * replaceAll
 * @param a
 * @param b
 * @returns {string}
 */
String.prototype.replaceAll = function (a, b) {
	return this.split(a).join(b);
};

// 영문숫자만인지 확인
String.prototype.isid = function() {
    if (this.search(/[^A-Za-z0-9_-]/) == -1)
        return true;
    else
        return false;
};

// 알파벳만이지 체크
String.prototype.isalpha = function() {
    if (this.search(/[^A-Za-z]/) == -1)
        return true;
    else
        return false;
};

// 숫자만인지 체크
String.prototype.isnumber = function() {
    if (this.search(/[^0-9]/) == -1)
        return true;
    else
        return false;
};

/**
 * Array 에서 해당 값 제거하기
 * @param val
 */
Array.prototype.removeByValue = function(val) {
    for(var i=0;i<this.length;i++){if(this[i]==val){this.splice(i,1);break;}}
};

// Array에 값 존재 여부
Array.prototype.contains = function(obj) {
	var i = this.length;
	while (i--) {
		if (this[i] === obj) {
			return true;
		}
	}
	return false;
};

/**
 * 배열의 중복을 제거한다.
 */
Array.prototype.unique = function () {
    var a = {};
    for (var i = 0; i < this.length; i++) {
        if (typeof a[this[i]] == "undefined")
            a[this[i]] = 1;
    }
    this.length = 0;
    for (var i in a)
        this[this.length] = i;
    return this;
}

/**
 * java map 과 사용법 같음
 *
 * put,get,containsKey,containsValue,isEmpty,clear,remove,keys,values,size
 *
 * ex)
 * var map = new Map();
 * map.put("user_id", "atspeed");
 * map.get("user_id");
 *
 * @constructor
 */
Map=function(){this.map=new Object();};Map.prototype={put:function(key,value){this.map[key]=value;},get:function(key){return this.map[key];},containsKey:function(key){return key in this.map;},containsValue:function(value){for(var prop in this.map){if(this.map[prop]==value)return true;}return false;},isEmpty:function(key){return(this.size()==0);},clear:function(){for(var prop in this.map){delete this.map[prop];}},remove:function(key){delete this.map[key];},keys:function(){var keys=new Array();for(var prop in this.map){keys.push(prop);}return keys;},values:function(){var values=new Array();for(var prop in this.map){values.push(this.map[prop]);}return values;},size:function(){var count=0;for(var prop in this.map){count++;}return count;}};

/**
 * byte 수에 따라 글자수 계산하기
 * @param value
 * @param maxLength
 * @param tail
 * @returns {*}
 */
var cutString = function (value, maxLength, tail) {
    var strlen=0;var str;tail=((tail==undefined)||(tail==''))?'...':tail;for(var i=0,len=value.length;i<len;i++){str=value.substr(i,1);if(escape(str).length>4){strlen=strlen+2;}else{strlen=strlen+1;}if(strlen>maxLength){return value.substring(0,i)+tail;}}return value;
};

/**
 * value 를 시:분:초 형태로 리턴하기
 * @param value
 * @returns {string}
 */
var changeSecondToHMS = function (value) {
    var rtValue="";if(value.length==8){h=value.substring(0,2);m=value.substring(3,5);s=value.substring(6,8);rtValue=parseInt(h*3600)+parseInt(m*60)+parseInt(s);}else{h=parseInt(value/3600);m=parseInt((value%3600)/60);s=parseInt(value%60);if(h!=0){rtValue=fillZero(h,2)+":";}rtValue+=fillZero(m,2)+":"+fillZero(s,2);}return rtValue;
};

/**
 * 현재 날짜를 YYYYMMDD 형식으로 가져온다
 * @param d : 현재 날짜에서 +,- 일자를 가져온다.
 * @returns {string}
 */
var getDateString = function(d){
    var date=new Date();if(d){date=new Date(date.valueOf()+(24*60*60*1000*d));}
    var yyyy=date.getFullYear().toString();var mm=(date.getMonth()+1).toString();var dd=date.getDate().toString();return yyyy+(mm[1]?mm:"0"+mm[0])+(dd[1]?dd:"0"+dd[0]);
};

/**
 * sDate 입력받은 날짜에 요일을 가져온다.
 * sDate = YYYY-MM-DD 형식으로 입력
 * @returns {string}
 */
var getWeekday	= function (sDate) {
    var yy = parseInt(sDate.substr(0, 4), 10);
    var mm = parseInt(sDate.substr(5, 2), 10);
    var dd = parseInt(sDate.substr(8), 10);

    var d = new Date(yy,mm - 1, dd);
    var weekday=new Array(7);
    weekday[0]="일";
    weekday[1]="월";
    weekday[2]="화";
    weekday[3]="수";
    weekday[4]="목";
    weekday[5]="금";
    weekday[6]="토";
    return weekday[d.getDay()];
}


/**
 * 3자리수마다 콤마넣기
 * @param n
 * @returns {*}
 */
var addComma = function (n) {
    if(!n)return 0;var reg=/(^[+-]?\d+)(\d{3})/;n+='';while(reg.test(n)){n=n.replace(reg,'$1'+','+'$2');}return n;
};

/**
 * 자리수 채우기
 * @param str
 * @param len
 * @returns {*}
 */
var fillZero = function (str, len) {
    var offset;var temp_str=$.trim(str+"");if(isNaN(temp_str)){return str;}if(temp_str.length>=len){return temp_str;}offset=len-temp_str.length;while(offset>0){switch(offset){case 1:offset=0;temp_str="0"+temp_str;break;case 2:offset=0;temp_str="00"+temp_str;break;}}return temp_str;
};

/**
 * 천단위 숫자에 "," 표시함
 * @param num
 * @returns {string}
 */
var fillCommaInNumber = function (num) {
	return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
};

/**
 * preventDefault
 *
 * @param event
 */
var pd = function (event) {
    if(event.preventDefault){event.preventDefault();}else{event.returnValue=false;}
};


/**
 * 알파벳만으로 구성된 문자열인지 체크합니다.
 */
function isAlphabet(str) {
    if (str.search(/[^a-zA-Z]/g) == -1)
        return true;
    else
        return false;
}

/**
 * 한글로만 구성된 문자열인지 체크합니다.
 */
function isKorean(str) {
    var strLength = str.length;
    var i;
    var Unicode;

    for (i = 0; i < strLength; i++) {
        Unicode = str.charCodeAt(i);
        if (!(44032 <= Unicode && Unicode <= 55203))
            return false;
    }
    return true;
}

/**
 * 문자열을 특정 문자열을 나눠 배열형태의 값으로 반환합니다.
 */
function StringTokenizer(str, separator) {
    arrayOfStrings = str.split(separator);
    return arrayOfStrings;
}

/**
 * 올바른 메일형식인지 체크합니다.
 */
function isValidEmail(str) {
    var re = new RegExp(
        "^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$",
        "gi");
    if (str.match(re))
        return true;
    else
        return false;
}

/**
 * 숫자만으로 구성된 문자열인지 체크합니다.
 */
function isDigit(str) {
    if (str.search(/[^0-9]/g) == -1)
        return true;
    else
        return false;
}

/**
 * 문자열이 NULL인지 체크합니다.
 */
function isNull(str) {
    if (str == null || str == "")
        return true;
    else
        return false;
}

/**
 * 문자열에 한칸이상의 스페이스 입력이 있는지를 체크합니다.
 */
function isValidSpace(str) {
    if (str.search(/[\s]{2,}/g) != -1)
        return false;
    else
        return true;
}

 
/**
 * object가 null 일 경우 원하는 문자열로 변환 
 */
function replaceNull(obj, str){
	var result = null;
	if(obj === null){
		result = str;
	}else{
		result = obj;
	}
	return result;
}

var popUpWindow;
/**
 * 윈도우 팝업
 *
 * @param url url주소
 * @param win_name 팝업이름
 * @param winWidth 넓이
 * @param winHeight 높이
 * @param Scroll 스크롤여부(Y,N)
 */
var onPopup = function(url, win_name, winWidth, winHeight, Scroll) {
	var winPosLeft = (screen.width - winWidth) / 2;
	var winPosTop = (screen.height - winHeight) / 2;
	var winOpt = "width=" + winWidth + ", height=" + winHeight + ",top=" + winPosTop + ",left=" + winPosLeft + ",scrollbars=" + Scroll + ",menubar=No, resizable=No,status=No,toolbar=No";

	popUpWindow = window.open(url, win_name, winOpt + "");
	popUpWindow.focus();
};

/**
 * onPopup으로 연 팝업 닫기
 */
var offPopup = function() {
    if(popUpWindow)
        popUpWindow.close();
};

/**
 * 파라미터 값
 *
 * @param query
 * @param key
 * @returns {string}
 */
var getParameter = function(query, key) {
	var parameters = (query).split('&');
	for (var i = 0; i < parameters.length; i++) {
		var varName = parameters[i].split('=')[0];
		if (varName.toUpperCase() == key.toUpperCase()) {
			return decodeURIComponent(parameters[i].split('=')[1]);
		}
	}
	return '';
};

$(function(){
	/**
	 *  숫자만 입력 가능한 텍스트박스
	 *  <input type="text" numberonly="true" />
	 */
	$(document).on("keyup", "input:text[numberOnly]", function() {
		this.value = this.value.replace(/\D/g, '');
	});
	
	/**
	 *  숫자만 입력 가능한 텍스트박스 숫자가 4자리 넘어가지 않게 
	 *  <input type="text" numberonly="true" />
	 */
	$(document).on("keyup", "input:text[numberOnlyPhoneF]", function() {
		if(this.value.length > 3 )
		{
			this.value = this.value.substr(0,3);
			return;
		}
		this.value = this.value.replace(/\D/g, '');
	});
	
	/**
	 *  숫자만 입력 가능한 텍스트박스 숫자가 5자리 넘어가지 않게 
	 *  <input type="text" numberonly="true" />
	 */
	$(document).on("keyup", "input:text[numberOnlyPhoneM]", function() {
		if(this.value.length > 4 )
		{
			this.value = this.value.substr(0,4);
			return;
		}
		this.value = this.value.replace(/\D/g, '');
	});
	
	/**
	 *  숫자만 입력 가능한 텍스트박스 숫자가 5자리 넘어가지 않게 
	 *  <input type="text" numberonly="true" />
	 */
	$(document).on("keyup", "input:text[numberOnlyPhoneL]", function() {
		if(this.value.length > 4 )
		{
			this.value = this.value.substr(0,4);
			return;
		}
		this.value = this.value.replace(/\D/g, '');
	});
	
	/**
	 *  숫자만 입력 가능한 텍스트박스 숫자가 5자리 넘어가지 않게 
	 *  <input type="text" numberonly="true" />
	 */
	$(document).on("keyup", "input:text[nameInput]", function() {
		if(this.value.length > 10 )
		{
			this.value = this.value.substr(0,10);
			return;
		}
	});
	

	/**
	 * 숫자, 콜론(:), 하이픈(-)만 입력 가능한 텍스트박스
	 * <input type="text" datetimeonly="true" />
	 */
	$(document).on("keyup", "input:text[datetimeOnly]", function() {
		$(this).val( $(this).val().replace(/[^0-9:\-]/gi,"") );
	});

	/**
	 * 숫자, 소숫점(.)만 입력 가능한 텍스트박스
	 * <input type="text" datetimeonly="true" />
	 */
	$(document).on("keyup", "input:text[percentOnly]", function() {
		$(this).val($(this).val().replace(/[^\d.]/g, '') );
	});
	
	/**
	 * 영문,숫자만 입력  가능한 텍스트박스
	 * <input type="text" datetimeonly="true" />
	 */
	$(document).on("keyup", "input:text[isid]", function() {
		$(this).val($(this).val().replace(/[^A-Za-z0-9_-]/, '') );
	});

	/**
	 * 숫자입력 후 3자리마다 콤마
	 * <input type="text" datetimeonly="true" />
	 */
	$(document).on("keyup", "input:text[numberComma]:not(.placeholder)", function() {
			this.value = this.value.replace(/\D/g, '');
			if(this.value != ''){
				$(this).val(addComma(this.value));
			}
	});
});

function lpad(str, n, c) {
    var i;
    var s = str.toString();
    var a = s.split('');
    for (i = 0; i < n - s.length; i++) {
        a.unshift(c);
    };
    return a.join('');
}

function replaceComma() {
	//숫자 콤마 제거
	$("input:text[numberComma]").filter(":not(.placeholder)").each(function(){
		this.value = this.value.replaceAll(',','');
		this.value = this.value.replaceAll('.','');
	});
}

//결제 관련 암호화
function MD5(sMessage) {
	 function RotateLeft(lValue, iShiftBits) {
	  return (lValue<<iShiftBits) | (lValue>>>(32-iShiftBits));
	 }
	 function AddUnsigned(lX,lY) {
	  var lX4,lY4,lX8,lY8,lResult;
	  lX8 = (lX & 0x80000000);
	  lY8 = (lY & 0x80000000);
	  lX4 = (lX & 0x40000000);
	  lY4 = (lY & 0x40000000);
	  lResult = (lX & 0x3FFFFFFF)+(lY & 0x3FFFFFFF);
	  if(lX4 & lY4)
	   return (lResult ^ 0x80000000 ^ lX8 ^ lY8);
	  if (lX4 | lY4) {
	   if (lResult & 0x40000000)
	    return (lResult ^ 0xC0000000 ^ lX8 ^ lY8);
	   else
	    return (lResult ^ 0x40000000 ^ lX8 ^ lY8);
	  }
	  else
	   return (lResult ^ lX8 ^ lY8);
	  }
	  
	 function F(x,y,z) {
	  return (x & y) | ((~x) & z);
	 }
	 function G(x,y,z) {
	  return (x & z) | (y & (~z));
	 }
	 function H(x,y,z) {
	  return (x ^ y ^ z);
	 }
	 function I(x,y,z) {
	  return (y ^ (x | (~z)));
	 }
	 function FF(a,b,c,d,x,s,ac) {
	  a = AddUnsigned(a, AddUnsigned(AddUnsigned(F(b, c, d), x), ac));
	  return AddUnsigned(RotateLeft(a, s), b);
	 }
	 function GG(a,b,c,d,x,s,ac) {
	  a = AddUnsigned(a, AddUnsigned(AddUnsigned(G(b, c, d), x), ac));
	  return AddUnsigned(RotateLeft(a, s), b);
	 }
	 function HH(a,b,c,d,x,s,ac) {
	  a = AddUnsigned(a, AddUnsigned(AddUnsigned(H(b, c, d), x), ac));
	  return AddUnsigned(RotateLeft(a, s), b);
	 }
	 function II(a,b,c,d,x,s,ac) {
	  a = AddUnsigned(a, AddUnsigned(AddUnsigned(I(b, c, d), x), ac));
	  return AddUnsigned(RotateLeft(a, s), b);
	 }
	 function ConvertToWordArray(sMessage) {
	  var lWordCount;
	  var lMessageLength = sMessage.length;
	  var lNumberOfWords_temp1=lMessageLength + 8;
	  var lNumberOfWords_temp2=(lNumberOfWords_temp1-(lNumberOfWords_temp1 % 64))/64;
	  var lNumberOfWords = (lNumberOfWords_temp2+1)*16;
	  var lWordArray = Array(lNumberOfWords-1);
	  var lBytePosition = 0;
	  var lByteCount = 0;
	  while ( lByteCount < lMessageLength ) {
	   lWordCount = (lByteCount-(lByteCount % 4))/4;
	   lBytePosition = (lByteCount % 4)*8;
	   lWordArray[lWordCount] = (lWordArray[lWordCount] | (sMessage.charCodeAt(lByteCount)<<lBytePosition));
	   lByteCount++;
	  }
	  lWordCount = (lByteCount-(lByteCount % 4))/4;
	  lBytePosition = (lByteCount % 4)*8;
	  lWordArray[lWordCount] = lWordArray[lWordCount] | (0x80<<lBytePosition);
	  lWordArray[lNumberOfWords-2] = lMessageLength<<3;
	  lWordArray[lNumberOfWords-1] = lMessageLength>>>29;
	  return lWordArray;
	 }
	 function WordToHex(lValue) {
	  var WordToHexValue="",WordToHexValue_temp="",lByte,lCount;
	  for (lCount=0; lCount<=3; lCount++) {
	   lByte = (lValue>>>(lCount*8)) & 255;
	   WordToHexValue_temp = "0" + lByte.toString(16);
	   WordToHexValue = WordToHexValue + WordToHexValue_temp.substr(WordToHexValue_temp.length-2,2);
	  }
	  return WordToHexValue;
	 }
	 var x = Array();
	 var k,AA,BB,CC,DD,a,b,c,d;
	 var S11=7, S12=12, S13=17, S14=22;
	 var S21=5, S22=9 , S23=14, S24=20;
	 var S31=4, S32=11, S33=16, S34=23;
	 var S41=6, S42=10, S43=15, S44=21;
	 // Steps 1 and 2.  Append padding bits and length and convert to words
	 x = ConvertToWordArray(sMessage);
	 // Step 3.  Initialise
	 a = 0x67452301; b = 0xEFCDAB89; c = 0x98BADCFE; d = 0x10325476;
	 // Step 4.  Process the message in 16-word blocks
	 for (k=0;k<x.length;k+=16) {
	  AA=a; BB=b; CC=c; DD=d;
	  a = FF(a,b,c,d,x[k+0], S11,0xD76AA478);
	  d = FF(d,a,b,c,x[k+1], S12,0xE8C7B756);
	  c = FF(c,d,a,b,x[k+2], S13,0x242070DB);
	  b = FF(b,c,d,a,x[k+3], S14,0xC1BDCEEE);
	  a = FF(a,b,c,d,x[k+4], S11,0xF57C0FAF);
	  d = FF(d,a,b,c,x[k+5], S12,0x4787C62A);
	  c = FF(c,d,a,b,x[k+6], S13,0xA8304613);
	  b = FF(b,c,d,a,x[k+7], S14,0xFD469501);
	  a = FF(a,b,c,d,x[k+8], S11,0x698098D8);
	  d = FF(d,a,b,c,x[k+9], S12,0x8B44F7AF);
	  c = FF(c,d,a,b,x[k+10],S13,0xFFFF5BB1);
	  b = FF(b,c,d,a,x[k+11],S14,0x895CD7BE);
	  a = FF(a,b,c,d,x[k+12],S11,0x6B901122);
	  d = FF(d,a,b,c,x[k+13],S12,0xFD987193);
	  c = FF(c,d,a,b,x[k+14],S13,0xA679438E);
	  b = FF(b,c,d,a,x[k+15],S14,0x49B40821);
	  a = GG(a,b,c,d,x[k+1], S21,0xF61E2562);
	  d = GG(d,a,b,c,x[k+6], S22,0xC040B340);
	  c = GG(c,d,a,b,x[k+11],S23,0x265E5A51);
	  b = GG(b,c,d,a,x[k+0], S24,0xE9B6C7AA);
	  a = GG(a,b,c,d,x[k+5], S21,0xD62F105D);
	  d = GG(d,a,b,c,x[k+10],S22,0x2441453);
	  c = GG(c,d,a,b,x[k+15],S23,0xD8A1E681);
	  b = GG(b,c,d,a,x[k+4], S24,0xE7D3FBC8);
	  a = GG(a,b,c,d,x[k+9], S21,0x21E1CDE6);
	  d = GG(d,a,b,c,x[k+14],S22,0xC33707D6);
	  c = GG(c,d,a,b,x[k+3], S23,0xF4D50D87);
	  b = GG(b,c,d,a,x[k+8], S24,0x455A14ED);
	  a = GG(a,b,c,d,x[k+13],S21,0xA9E3E905);
	  d = GG(d,a,b,c,x[k+2], S22,0xFCEFA3F8);
	  c = GG(c,d,a,b,x[k+7], S23,0x676F02D9);
	  b = GG(b,c,d,a,x[k+12],S24,0x8D2A4C8A);
	  a = HH(a,b,c,d,x[k+5], S31,0xFFFA3942);
	  d = HH(d,a,b,c,x[k+8], S32,0x8771F681);
	  c = HH(c,d,a,b,x[k+11],S33,0x6D9D6122);
	  b = HH(b,c,d,a,x[k+14],S34,0xFDE5380C);
	  a = HH(a,b,c,d,x[k+1], S31,0xA4BEEA44);
	  d = HH(d,a,b,c,x[k+4], S32,0x4BDECFA9);
	  c = HH(c,d,a,b,x[k+7], S33,0xF6BB4B60);
	  b = HH(b,c,d,a,x[k+10],S34,0xBEBFBC70);
	  a = HH(a,b,c,d,x[k+13],S31,0x289B7EC6);
	  d = HH(d,a,b,c,x[k+0], S32,0xEAA127FA);
	  c = HH(c,d,a,b,x[k+3], S33,0xD4EF3085);
	  b = HH(b,c,d,a,x[k+6], S34,0x4881D05);
	  a = HH(a,b,c,d,x[k+9], S31,0xD9D4D039);
	  d = HH(d,a,b,c,x[k+12],S32,0xE6DB99E5);
	  c = HH(c,d,a,b,x[k+15],S33,0x1FA27CF8);
	  b = HH(b,c,d,a,x[k+2], S34,0xC4AC5665);
	  a = II(a,b,c,d,x[k+0], S41,0xF4292244);
	  d = II(d,a,b,c,x[k+7], S42,0x432AFF97);
	  c = II(c,d,a,b,x[k+14],S43,0xAB9423A7);
	  b = II(b,c,d,a,x[k+5], S44,0xFC93A039);
	  a = II(a,b,c,d,x[k+12],S41,0x655B59C3);
	  d = II(d,a,b,c,x[k+3], S42,0x8F0CCC92);
	  c = II(c,d,a,b,x[k+10],S43,0xFFEFF47D);
	  b = II(b,c,d,a,x[k+1], S44,0x85845DD1);
	  a = II(a,b,c,d,x[k+8], S41,0x6FA87E4F);
	  d = II(d,a,b,c,x[k+15],S42,0xFE2CE6E0);
	  c = II(c,d,a,b,x[k+6], S43,0xA3014314);
	  b = II(b,c,d,a,x[k+13],S44,0x4E0811A1);
	  a = II(a,b,c,d,x[k+4], S41,0xF7537E82);
	  d = II(d,a,b,c,x[k+11],S42,0xBD3AF235);
	  c = II(c,d,a,b,x[k+2], S43,0x2AD7D2BB);
	  b = II(b,c,d,a,x[k+9], S44,0xEB86D391);
	  a = AddUnsigned(a,AA); b=AddUnsigned(b,BB); c=AddUnsigned(c,CC); d=AddUnsigned(d,DD);
	 }
	 // Step 5.  Output the 128 bit digest
	 var temp = WordToHex(a) + WordToHex(b) + WordToHex(c) + WordToHex(d);
	 return temp.toLowerCase();
	}


/** 
 * 이미지 미리보기
 * obj : $('#id')
 * preImg : 미리보기 들어갈 'id'
 * width : 이미지 width
 * height : 이미지 height
 * */
function previewImg(obj, preImg, width, height) {

	$('#'+preImg).show();
	
    if (obj.val() != "") {
		if ( window.FileReader ) {
			 /*IE 10 이상에서는 FileReader  이용*/
			var reader = new FileReader();
		        reader.onload = function (e) {
		        	
		        	var img = new Image;
		            img.onload = function() {
		              //console.log("width : " + img.width + "px.");
		              //console.log("height : " + img.height + "px.");
		            };
		            img.src = reader.result;
		        	
		            $('#'+preImg).attr('src', e.target.result);
		            $('#'+preImg).width(width + 'px');
		            //$('#'+preImg).height(height + 'px');
		            
		        };
		        /* 
		        var file = document.getElementById(obj).files[0];
		        reader.readAsDataURL(file);
		        return file.name;  // 파일명 return
		         */
		        reader.readAsDataURL(obj[0].files[0]);
		        return obj[0].files[0].name;  // 파일명 return

		} else {
			
			$('#'+preImg).attr('src', "");	//초기화

			obj.select();
			var src = document.selection.createRangeCollection()[0].text;
			//console.log("src : " + src);
			
			var img = document.getElementById(preImg); //이미지가 뿌려질 곳
			
			img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"
                + src + "', sizingMethod='scale')";
			
			$('#'+preImg).width(width + 'px');
            //$('#'+preImg).height(height + 'px');
			 
			
			var n = src.substring(src.lastIndexOf('\\') + 1);
			return n; // 파일명 return
		}
    }
}
function Encrypt(theText){
	output = new String;
	Temp = new Array();
	Temp2 = new Array();
	TextSize = theText.length;
	for (i=0;i < TextSize; i++){
		rnd = Math.round(Math.random()*122) + 68;
		Temp[i] = theText.charCodeAt(i) +rnd;
		Temp2[i] = rnd;
	}
	for (i = 0; i < TextSize; i++){
		output += String.fromCharCode(Temp[i], Temp2[i]);
	}
	return output;
}

function unEncrypt(theText){
	output = new String;
	Temp = new Array();
	Temp2 = new Array();
	TextSize = theText.length;
	for (i =0 ; i < TextSize ; i++){
		Temp[i] = theText.charCodeAt(i);
		Temp2[i] = theText.charCodeAt(i+1);
	}
	for (i = 0; TextSize; i+2){
		output += String.fromCharCode(Temp[i] - Temp2[i]);
	}
	return output;
}