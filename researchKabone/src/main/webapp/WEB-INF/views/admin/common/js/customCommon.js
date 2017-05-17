	/**
	 * 문자열 데이터를 YYYY-MM-DD 형의 스트링으로 리턴
	 * @param data : 스트링형(YYYYMMDD)
	 * @returns {String}
	 */
	function getFormatDate_stos(data) {
		var sMonth	= data.substring(4,6);
		var sDate	= data.substring(6,8);
		var sYear	= data.substring(0,4);
		return sYear + "-" + sMonth + "-" + sDate;
	}

	/**
	 * 날짜 데이터를 YYYY-MM-DD 형의 스트링으로 리턴
	 * @param data : 데이터형
	 * @returns {String}
	 */
	function getFormatDate(data) {
		var sMonth	= getStrMonth(data.getMonth()+1);
		var sDate	= getStrDay(data.getDate());
		var sYear	= data.getFullYear();
		return sYear + "-" + sMonth + "-" + sDate;
	}
	
	/**
	 * 오늘 날짜를 YYYY-MM-DD 형의 스트링으로 리턴
	 * @returns {String}
	 */
	function getToday() {
		var dtNow = new Date();
		var nowDate = getStrDay(dtNow.getDate());
		var nowMonth = getStrMonth(dtNow.getMonth()+1);
		
		return dtNow.getFullYear() + "-" + nowMonth + "-" + nowDate;
	}
	
	/**
	 * 계산할 날짜값을 입력받아 계산 후 오브젝트의 value 로 세팅
	 * @param mVal : 음수(-7), 양수(5) 등을 입력받아 날짜 계산
	 * @param obj1 : $("#input_id") 계산한 날짜값을 입력할 start_date Object
	 * @param obj2 : $("#input_id") 현재 날짜가 세팅되는 end_date Object
	 */
	function fnGetCalDate(mVal, obj1, obj2) {
		var sDate = new Date();
		sDate.setDate(sDate.getDate() + mVal+1);
		
		obj1.val(getFormatDate(sDate));
		obj2.val(getFormatDate(new Date()));
	}
	/**
	 * 오늘만, 내일만, 어제만... 특정일
	 * @param mVal -? 오늘기준으로 +-
	 * @param obj1
	 * @param obj2
	 */
	function fnGetTargetDay(mVal, obj1, obj2) {
		var sDate = new Date();
		sDate.setDate(sDate.getDate() + mVal);
		
		obj1.val(getFormatDate(sDate));
		obj2.val(getFormatDate(sDate));
	}
	
	/**
	 * 오늘만, 내일만, 어제만... 특정일
	 * @param mVal -? 오늘기준으로 +-
	 * @param obj1
	 */
	function fnGetToDay(mVal, obj1) {
		var sDate = new Date();
		sDate.setDate(sDate.getDate() + mVal);
		
		obj1.val(getFormatDate(sDate));
	}
	
	
	/**
	 * 계산할 월(month) 값을 입력받아 계산 후 오브젝트의 value로 세팅
	 * @param mVal : 음수(-7), 양수(5) 등을 입력받아 월 계산
	 * @param obj1 : $("#input_id") 계산한 날짜값을 입력할 start_date Object
	 * @param obj2 : $("#input_id") 현재 날짜가 세팅되는 end_date Object
	 */
	function fnGetCalMonth(mVal, obj1, obj2) {
		var dm1, dm2;
		dm1 = new Date();
		dm2 = new Date(dm1.getFullYear(), dm1.getMonth()+mVal, dm1.getDate()+1);
		
		obj1.val(getFormatDate(dm2));
		obj2.val(getFormatDate(new Date()));
	}
	
	/**
	 * YYYY-MM-DD 스트링을 입력받아 Date 형으로 변환
	 * @param mDate
	 * @returns {Date}
	 */
	function fnSetDateString(mDate){
		mDate = mDate.replace(/-/gi, "");
		//console.log(" ["+mDate.substring(0, 4)+"] ["+mDate.substring(4, 6)+"] ["+mDate.substring(6, 8)+"] ");
		
		var pDate = new Date();
		pDate.setFullYear(parseFloat(mDate.substring(0, 4)), parseFloat(mDate.substring(4, 6)), parseFloat(mDate.substring(6, 8)));
		//console.log(pDate.getDate() + " || " + pDate.getMonth() + " || " + pDate.getFullYear());
		return pDate;
	}
	
	/**
	 * 월(month)을 입력받아 10이하면 '0'을 붙여 리턴
	 * @param Month
	 * @returns {String}
	 */
	function getStrMonth(Month) {  
		Month = Month + "";  
		if (Month.length == 1) {  
			Month = "0" + Month;  
		}  
		return Month;  
	}  

	/**
	 * 날짜를 입력받아 10이하면 '0'을 붙여 리턴
	 * @param Day
	 * @returns {String}
	 */
	function getStrDay(Day) {  
		Day = Day + "";  
		if (Day.length == 1) {  
			Day = "0" + Day;  
		}  
		return Day;  
	}
	
	/**
	 * FORM RESET 함수
	 */
	$.fn.clearForm = function() {
		return this.each(function() {
			var type = this.type, tag = this.tagName.toLowerCase();
			if (tag == 'form')
				return $(':input',this).clearForm();
			if (type == 'text' || type == 'password' || tag == 'textarea')
				this.value = '';
			else if (type == 'checkbox' || type == 'radio')
				this.checked = false;
			else if (tag == 'select')
				this.selectedIndex = 0;
		});
	};
	
	/**
	 * @brief	    : 금액에 comma로 구분
	 * @details	: 거리값에 comma로 구분하여 리턴
	 * @return     : comma가 추가된 거리값
	 * @date	    : 2014/10/20
	 *
	 * @remark	: 주의사항
	 */
	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	/**
	 * @brief	    : 금액에 comma제거
	 * @details	: 거리값에 comma로 구분하여 리턴
	 * @return     : comma가 추가된 거리값
	 * @date	    : 2014/10/20
	 *
	 * @remark	: 주의사항
	 */
	function uncomma(str) {
	    str = String(str);
	    return str.replace(/[^\d]+/g, '');
	}
	
	/**
	 * @brief	     : String 에 취소선 표시
	 * @details	 : Number type parameter를 String으로 변환후 취소선 표시
	 * @param dcAmtNum : 할인권 금액
	 * @date	     : 2014/09/18
	 *
	 * @remark	     : 주의사항
	 */
	function applyLineThrough(dcAmtNum) {
	    var dcAmtStr = String(dcAmtNum);
	    dcAmtStr = dcAmtStr.replace(/\d/g, function (digit) { return digit + "\u0336" });	    
	    return dcAmtStr;
	}
	
	
	/**
	 * @brief	     : 모바일 유무
	 * @details	 : 
	 * @param 
	 * @date	     : 2016/10/31
	 *
	 * @remark	     : 주의사항
	 */
	function isMobile(){
		var currentOS;
		var mobile = (/iphone|ipad|ipod|android/i.test(navigator.userAgent.toLowerCase()));
		 
		if (mobile) {
			// 유저에이전트를 불러와서 OS를 구분합니다.
			var userAgent = navigator.userAgent.toLowerCase();
			if (userAgent.search("android") > -1)
				currentOS = "android";
			else if ((userAgent.search("iphone") > -1) || (userAgent.search("ipod") > -1)
						|| (userAgent.search("ipad") > -1))
				currentOS = "ios";
			else
				currentOS = "else";
		} else {
			// 모바일이 아닐 때
			currentOS = "nomobile";
		}
		
		return currentOS;
	}
	
	
	
	
	