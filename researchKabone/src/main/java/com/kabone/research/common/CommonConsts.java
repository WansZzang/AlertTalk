package com.kabone.research.common;

public class CommonConsts {
	
	//public static final String SPRING_SECURITY_LAST_EXCEPTION_KEY = "SPRING_SECURITY_LAST_EXCEPTION";
	public static final int DEFAULT_CONNECTION_COUNT	= 3;
	public static final int CONNECTION_TIMEOUT 			= 30000;
	public static final int SO_TIMEOUT 					= 30000;

	public static final String SEED_HASH = "66B62E8920FA1DE5";
	public static final String SESS_AGREE = "_fintech_agree_ssesion";	//session column
	
	public static final String IS_DEBUGING = "Y";	//
	
	public static final String HEADER_X_AUTH_USERNO = "X-Auth-UserNo";	
	public static final String HEADER_X_AUTH_TOKEN = "X-Auth-Token";
	
	
	
	public static final String SP_RTN_CD_SUCCESS = "0000";	
	public static final String SP_RTN_CD_FAILURE = "1000";
	
	
	//log prefix
	public static final String DB_LOG = "db.log";
	
	
	//action
	public static final String ACTION_CREATE = "CREATE";	
	public static final String ACTION_DETAIL = "DETAIL";	
	public static final String ACTION_EDIT = "EDIT";	

	
	//email 타입
	public static final int EMAIL_TYPE_NEWS_LETTERS				= 0; //뉴스레터, 					from 관리, to 회원
	public static final int EMAIL_TYPE_JOIN_AUTHENTICATION      = 1; //회원가입확인(이메일 인증), 		from 관리, to 회원
	public static final int EMAIL_TYPE_PASSWORD_CHANGE			= 2; //비밀번호재설정, 				from 관리, to 회원
	public static final int EMAIL_TYPE_BUSINESS_REG_ACK         = 3; //사업자등록증승인처리결과(승인/거절), from 관리, to 회원
	public static final int EMAIL_TYPE_BUSINESS_REG_CANCELED	= 4; //사업자등록증인증취소, 			from 관리, to 회원
	public static final int EMAIL_TYPE_QUIRY_ANSWER           	= 5; //1:1문의답변, 				from 관리, to 회원
	public static final int EMAIL_TYPE_PROJECT_OPEN_REQ			= 6; //프로젝트개설신청, 				from 관리, to 개설자
	public static final int EMAIL_TYPE_PROJECT_OPEN_ACK			= 7; //프로젝트개설승인, 				from 관리, to 개설자
	public static final int EMAIL_TYPE_PROJECT_OPEN_REFUSAL		= 8; //프로젝트개설승인반려, 			from 관리, to 개설자
	public static final int EMAIL_TYPE_PROJECT_SUCCESS			= 9; //프로젝트마감(성공), 			from 관리, to 개설자
	public static final int EMAIL_TYPE_PROJECT_FAILED           = 10; //프로젝트마감(종료/실패), 		from 관리, to 개설자
	public static final int EMAIL_TYPE_PROJECT_END_SUCCESS      = 11; //프로젝트마감(성공), 			from 관리, to 프로젝트후원자
	public static final int EMAIL_TYPE_PROJECT_END_FAILED       = 12; //프로젝트마감(종료/실패), 		from 관리, to 프로젝트후원자
	public static final int EMAIL_TYPE_MOIM_OPEN_ACK			= 13; //모임개설완료메일, 			from 관리, to 개설자
	public static final int EMAIL_TYPE_MOIM_JOIN_ACK            = 14; //모임가입승인완료, 			from 관리, to 모임회원
	public static final int EMAIL_TYPE_MOIM_RULE_CHANGED		= 15; //모임회칙개정안내, 			from 관리, to 모임회원
	public static final int EMAIL_TYPE_MOIM_SUCCESS				= 16; //모임성공, 					from 관리, to 모임회원
	public static final int EMAIL_TYPE_MOIM_END                 = 17; //모임종료, 					from 관리, to 모임회원
	public static final int EMAIL_TYPE_MOIM_FEE_DEFAULT			= 18; //모임회비미납안내, 			from 운영자, to 모임회원
	public static final int EMAIL_TYPE_MOIM_FREE                = 19; //모임임의발송, 				from 운영자, to 모임회원
	public static final int EMAIL_TYPE_ADMIN_FREE               = 20; //관리임의발송, 				from 관리자, to 전체/프로젝트/개인
	public static final int EMAIL_TYPE_JOIN_AUTHENTICATION2     = 21; //이메일 재인증, 				from 관리, to 회원
	public static final int EMAIL_TYPE_HELP_PROJECT     		= 22; //프로젝트 등록 지원 신청 알림,		from 회원, to 관리 
	
	
	public static final String EMAIL_TYPE_COMMON_TITLE					= "[금수저] ";
	public static final String EMAIL_TYPE_COMMON_SENDER					= "금수저";
	public static final String EMAIL_TYPE_COMMON_MAIN_ADDR				= "help@keywesoft.co.kr";
	public static final String EMAIL_TYPE_JOIN_AUTHENTICATION_TITLE		= "[금수저] 회원 가입을 환영합니다."; 
	public static final String EMAIL_TYPE_PASSWORD_CHANGE_TITLE			= "[금수저] 비밀번호 재 설정 안내";
	public static final String EMAIL_TYPE_BUSINESS_REG_ACK_TITLE       	= "[금수저] 사업자 등록이 승인되었습니다.";
	public static final String EMAIL_TYPE_BUSINESS_REG_ACK_TITLE2      	= "[금수저] 사업자 등록 신청이 반려되었습니다.";		
	public static final String EMAIL_TYPE_BUSINESS_REG_CANCELED_TITLE	= "[금수저] 사업자 등록 인증이 취소되었습니다.";
	public static final String EMAIL_TYPE_QUIRY_ANSWER_TITLE           	= "[금수저] 1:1 문의에 대한 답변입니다.";
	public static final String EMAIL_TYPE_PROJECT_OPEN_REQ_TITLE		= "[금수저] 후원형 프로젝트가 신청접수 되었습니다."; 			// + (프로젝트명 : 영광굴비로 만드는 유기농 된장 개발)
	public static final String EMAIL_TYPE_PROJECT_OPEN_ACK_TITLE		= "[금수저] 신청하신 후원형 프로젝트가 개설되었습니다."; 		// + (프로젝트명 : 영광굴비로 만드는 유기농 된장 개발)
	public static final String EMAIL_TYPE_PROJECT_OPEN_REFUSAL_TITLE	= "[금수저] 신청하신 프로젝트 승인 처리 결과를 알려드립니다."; 	// + (프로젝트명 : 영광굴비로 만드는 유기농 된장 개발)
	public static final String EMAIL_TYPE_PROJECT_SUCCESS_TITLE			= "[금수저] 신청하신 프로젝트가 성공적으로 마감되었습니다."; 	// + (프로젝트명 : 영광굴비로 만드는 유기농 된장 개발)
	public static final String EMAIL_TYPE_PROJECT_FAILED_TITLE         	= "[금수저] 신청하신 프로젝트가 종료되었습니다."; 			// + (프로젝트명 : 영광굴비로 만드는 유기농 된장 개발)
	public static final String EMAIL_TYPE_PROJECT_END_SUCCESS_TITLE    	= "[금수저] 후원하신 프로젝트가 성공적으로 마감되었습니다."; 	// + (프로젝트명 : 영광굴비로 만드는 유기농 된장 개발)
	public static final String EMAIL_TYPE_PROJECT_END_FAILED_TITLE     	= "[금수저] 후원하신 프로젝트가 종료되었습니다."; 			// + (프로젝트명 : 영광굴비로 만드는 유기농 된장 개발)
	public static final String EMAIL_TYPE_MOIM_OPEN_ACK_TITLE			= " 기금형 모임이 개설되었습니다.";							//"[금수저] 김가김가 기금형 모임이 개설되었습니다.";
	public static final String EMAIL_TYPE_MOIM_JOIN_ACK_TITLE          	= " 기금형 모임에 가입승인이 완료되었습니다."; 					//"[금수저] 김가김가 기금형 모임에 가입승인이 완료되었습니다.";
	public static final String EMAIL_TYPE_MOIM_RULE_CHANGED_TITLE		= " 기금형 모임의 회칙이 개정되었습니다."; 					//"[금수저] 김가김가 기금형 모임의 회칙이 개정되었습니다."; 
	public static final String EMAIL_TYPE_MOIM_SUCCESS_TITLE			= " 기금형 모임이 목표달성에 성공하였습니다!!!"; 				//"[금수저] 김가김가 기금형 모임이 목표달성에 성공하였습니다!!!";
	public static final String EMAIL_TYPE_MOIM_END_TITLE               	= " 기금형 모임이 아래와 같은 사유로 종료되었습니다."; 			//"[금수저] 김가김가 기금형 모임이 아래와 같은 사유로 종료되었습니다.";  
	public static final String EMAIL_TYPE_MOIM_FEE_DEFAULT_TITLE		= " 기금형 모임에 미납이 발생하여 안내 드립니다."; 				//"[금수저] 김가김가 기금형 모임에 미납이 발생하여 안내 드립니다.";  
	public static final String EMAIL_TYPE_MOIM_FREE_TITLE              	= " 기금형 모임에서 알려드립니다.";      					//"[금수저] 김가김가 기금형 모임에서 알려드립니다.";  
	public static final String EMAIL_TYPE_ADMIN_FREE_TITLE             	= "[금수저] 금수저에서 알려드립니다."; 			
	public static final String EMAIL_TYPE_JOIN_AUTHENTICATION2_TITLE   	= "[금수저] 비밀번호 재 설정 안내";
	public static final String EMAIL_TYPE_HELP_PROJECT_TITLE     		= "[금수저]프로젝트 등록 지원 신청이 접수 되었습니다."; 
	 
	
	
	
	
	
	
	
	//프로젝트 타입
	public static final String PROJECT_TYPE_MOIM 	= "M";	//모임
	public static final String PROJECT_TYPE_FARM	= "F";	//농어촌
	public static final String PROJECT_TYPE_IT		= "I";	//IT
	
	//결제상품 타입(기금형/후원형)
	public static final String PAY_PRODUCT_TYPE_FUNDS 	= "F";	//기금형
	public static final String PAY_PRODUCT_TYPE_SPONSOR = "S";	//후원형
	//결제 타입
	public static final String PAY_TYPE_SEYFERT_POINT 	= "S";	//세이퍼트 포인트
	public static final String PAY_TYPE_CREDIT_CARD 	= "P";	//신용카드
	public static final String PAY_TYPE_ACCOUNT_TRANS 	= "A";	//계좌이체
	public static final String PAY_TYPE_VACCOUNT_TRANS 	= "V";	//가상계좌(무통장)
	public static final String PAY_TYPE_PAYPAL 			= "P";	//페이팔	
	//카드타입(국내/해외)
	public static final String CREDIT_CARD_TYPE_DOMESTIC	= "D";	//국내카드
	public static final String CREDIT_CARD_TYPE_OVERSEAS	= "O";	//해외카드
	//결제디바이스 타입(WEB/MOBILE)
	public static final String PAY_DEVICE_TYPE_WEB 		= "W";	//WEB
	public static final String PAY_DEVICE_TYPE_ANDROID	= "A";	//ANDROID
	public static final String PAY_DEVICE_TYPE_IOS		= "I";	//IOS
	//현금영수증 발급 구분(00:발급안함, 01:소득공제용, 02:지출증빙용, 03:휴대폰번호입력))
	public static final String PAY_CASH_RECEIPT_TYPE_NO 		= "00";	//발급안함
	public static final String PAY_CASH_RECEIPT_TYPE_TAX_RETURN = "01";	//소득공제용
	public static final String PAY_CASH_RECEIPT_TYPE_EVIDENCE 	= "02";	//지출증빙용
	public static final String PAY_CASH_RECEIPT_TYPE_HP	 		= "03";	//휴대폰번호입력
		
	//send mail flag
	public static final String MAIL_SEND_TYPE_SMTP 		= "SMTP";	
	public static final String MAIL_SEND_TYPE_MAILGUN 	= "MAILGUN";
		
	
	//중복체크 타입
	public static final String DUPLICATE_CHK_TYPE_ID = "00";	//ID
	public static final String DUPLICATE_TYPE_HP = "02";		//HP
	public static final String DUPLICATE_TYPE_EMAIL = "01";		//EMAIL
	
	//-------------------------------------------------------------
	//문자메시지 파라미터 명칭
	//-------------------------------------------------------------
	public static final int SMS_TYPE_DOM_SMS 		= 0;	//국내 SMS
	public static final int SMS_TYPE_DOM_LMS 		= 1;	//국내 LMS
	public static final int SMS_TYPE_INT_SMS 		= 2;	//국제 문자
	
	public static final String SMS_ENCODING_TYPE 	= "UNICODE";	//"utf-16"
	
	public static final String DOM_SMS_SUCCESS_MSG = "SUCCESS";	//요청 응답 메시지
	public static final String DOM_LMS_SUCCESS_MSG = "succ";
	public static final String INT_SMS_SUCCESS_MSG = "SUCCESS";
	
	//parameter - 문자메시지 - 국내 SMS
	public static final String DOM_SMS_USERCODE = "usercode";	//ID
	public static final String DOM_SMS_DEPTCODE = "deptcode";	//회사코드 
	public static final String DOM_SMS_RECEIVER = "group_name";	//수신자
	public static final String DOM_SMS_SENDER1 = "from_num1";	//발신자 앞자리
	public static final String DOM_SMS_SENDER2 = "from_num2";	//발신자 중간자리
	public static final String DOM_SMS_SENDER3 = "from_num3";	//발신자 끝자리
	public static final String DOM_SMS_MEMBER = "member";		//일련번호
	public static final String DOM_SMS_MESSAGE = "to_message";	//메시지
	public static final String DOM_SMS_ENCODING = "encoding";	//인코딩
	public static final String DOM_SMS_RETURN_URL = "rurl";		//redirect url
	public static final String DOM_SMS_RESERVED = "rdate";		//예약시간
	
	//parameter - 문자메시지 - 국내 LMS
	public static final String DOM_LMS_USERCODE = "usercode";	//ID
	public static final String DOM_LMS_DEPTCODE = "deptcode";	//회사코드
	public static final String DOM_LMS_RECEIVER = "callphone";	//수신자
	public static final String DOM_LMS_SENDER = "reqphone";		//발신자
	public static final String DOM_LMS_MEMBER = "member";		//메시지
	public static final String DOM_LMS_MESSAGE = "message";		//일련번호
	public static final String DOM_LMS_ENCODING = "encoding";	//인코딩
	public static final String DOM_LMS_RESERVED = "rtime";		//예약시간
	
	//parameter - 문자메시지 - 국내 SMS
	public static final String INT_SMS_USERCODE = "usercode";	//ID
	public static final String INT_SMS_DEPTCODE = "deptcode";	//회사코드
	public static final String INT_SMS_RECEIVER = "group_name";	//수신자
	public static final String INT_SMS_SENDER = "from_num";		//발신자
	public static final String INT_SMS_MEMBER = "member";		//일련번호
	public static final String INT_SMS_MESSAGE = "to_message";	//메시지
	public static final String INT_SMS_ENCODING = "encoding";	//인코딩
	public static final String INT_SMS_RETURN_URL = "rurl";		//redirect url
	public static final String INT_SMS_RESERVED = "rdate";		//예약시간
	
	
	//-------------------------------------------------------------
	//실명인증 & 휴대폰인증 -> 휴대폰인증은 직접 구현해야 함
	//-------------------------------------------------------------
	public static final int AUTH_TYPE_DOM_AUTH 		= 0;	//국내 AUTH
	public static final int AUTH_TYPE_INT_AUTH 		= 1;	//국제 AUTH
	
	//결과타입
	public static final String DOM_AUTH_REDIRECT = "response";
	
	//parameter - 실명인증 - 인증번호 생성
	public static final String DOM_AUTH_ID = "user_id";		//거래 ID
	public static final String DOM_AUTH_DEPTID = "deptid";		//고객사 고유값
	public static final String DOM_AUTH_PHONENO = "phoneno";	//휴대폰번호
	public static final String DOM_AUTH_BIRTHDAY = "birthday";	//생년월일, YYYYMMDD
	public static final String DOM_AUTH_GENDER = "gender";		//성별, 0:남, 1:여
	public static final String DOM_AUTH_NAME = "name";			//이름
	public static final String DOM_AUTH_MOBILECO = "mobileco";	//이통사, 1:SKT, 2:KT, 3:LGU+, 4:SKT mvno, 5:KT mvno, 6:LGU+ mvno
	public static final String DOM_AUTH_S_URL = "surl";			//성공시 결과타입
	public static final String DOM_AUTH_F_URL = "furl";			//실패시 결과타입
	
	public static final String DOM_AUTH_KEY = "sms_no";			//인증번호
	public static final String DOM_AUTH_ORDER_ID = "order_id";	//거래번호1
	public static final String DOM_AUTH_SERIAL = "authserial";	//거래번호2
	public static final String DOM_AUTH_TIME = "authtime";		//거래시간
	
	public static final String SMS_AUTH_NOTI_MSG = "[금수저 회원가입] 인증번호: ";
	
	public static final String step1err_000 = "인증성공";
	public static final String step1err_901 = "등록되지 않은 사용자";
	public static final String step1err_902 = "IP사용제한";
	public static final String step1err_903 = "업체별 일일 사용건수 초과";
	public static final String step1err_905 = "user_id 누락";
	public static final String step1err_013 = "휴대폰번호 누락";
	public static final String step1err_014 = "이통사 누락";
	public static final String step1err_015 = "생년월일 누락";
	public static final String step1err_016 = "성별 누락";
	public static final String step1err_018 = "성명 누락";
	public static final String step1err_019 = "휴대폰 길이 오류";
	public static final String step1err_020 = "휴대폰 국번 오류";
	public static final String step1err_021 = "이동통신사 구분 오류";
	public static final String step1err_022 = "생년월일 자릿수 오류";
	public static final String step1err_023 = "성별 구분 오류";
	public static final String step1err_025 = "성명 길이 오류";
	public static final String step1err_032 = "일 3회 인증 실패";
	public static final String step1err_149 = "분실 또는 일시정지 휴대폰";
	public static final String step1err_150 = "사업자(법인) 명의의 휴대폰";
	public static final String step1err_151 = "휴대폰 번호 또는 통신사 불일치";
	public static final String step1err_152 = "생년월일 또는 성별정보 불일치";
	public static final String step1err_153 = "성명정보 불일치";
	public static final String step1err_154 = "입력정보 불일치";
	public static final String step1err_155 = "제한 요금제 가입자";
	public static final String step1err_156 = "선불 휴대폰번호";
	public static final String step1err_157 = "통신사의 일시적인 시스템 오류";
	public static final String step1err_158 = "통신사의 일시적인 시스템 오류";
	
	public static final String step2err_000 = "인증성공";
	public static final String step2err_901 = "인증레코드 없음";
	public static final String step2err_001 = "인증번호 불일치 (실패)";
	public static final String step2err_002 = "인증번호 5회 오류횟수 초과";
	public static final String step2err_011 = "인증번호 누락";
	public static final String step2err_012 = "인증번호 길이 오류";
	public static final String step2err_013 = "슈어엠 내부오류";
	public static final String step2err_014 = "authserial 오류";
	public static final String step2err_015 = "authserial 오류";
	public static final String step2err_016 = "authserial 오류";
	public static final String step2err_017 = "authserial 오류";
	public static final String step2err_018 = "authserial 오류";
	public static final String step2err_019 = "authserial 오류";
	
	//-------------------------------------------------------------
	//STATUS
	//-------------------------------------------------------------
	//PNS, EMAIL,,,,,
	public static final String TYPE_RESULT_STATUS_WAIT = "W";	//대기
	public static final String TYPE_RESULT_STATUS_SEND = "S";	//전송성공
	public static final String TYPE_RESULT_STATUS_FAIL = "F";	//전송실패
	public static final String TYPE_RESULT_STATUS_EMPTY = "E";	//대상없음
	public static final String TYPE_RESULT_STATUS_MOVE = "M";	//이관
	public static final String TYPE_RESULT_STATUS_RESERV = "R";	//예약
	
	//-------------------------------------------------------------
	//대상타입
	//-------------------------------------------------------------
	//PNS, EMAIL, SMS
	public static final String TYPE_TARGET_TITLE = "T";		//전체
	public static final String TYPE_TARGET_PROJECT = "P";	//프로젝트
	public static final String TYPE_TARGET_CREATOR = "C";	//개설자
	public static final String TYPE_TARGET_MANAGER = "M";	//총무
	public static final String TYPE_TARGET_USER = "U";		//사용자
	
	//-------------------------------------------------------------
	//결과타입
	//-------------------------------------------------------------
	public static final String TYPE_FLAG_YES = "Y";
	public static final String TYPE_FLAG_NO = "N";
	
	//-------------------------------------------------------------
	//국가코드
	//-------------------------------------------------------------
	
	public static final String COUNTRY_KO = "ko";
	public static final String COUNTRY_USA = "us";
	public static final String COUNTRY_JAPAN = "ja";
	public static final String COUNTRY_CHINA = "ch";
	
	//-------------------------------------------------------------
	//코드타입(tn_code > CODE_TYPE)
	//-------------------------------------------------------------
	public static final String CODE_TYPE_USERLEVEL = "01";	//유저레벨
	public static final String CODE_TYPE_VIEWTYPE = "02";	//뷰타입
	
	//00:회원(흙수저), 01:동수저, 02:은수저, 03:금수저
	public static final String LEVEL_NORMAL = "00";
	public static final String LEVEL_DONG 	= "01";
	public static final String LEVEL_SILVER = "02";
	public static final String LEVEL_GOLD 	= "03";
	
	public static final String PAY_TYPE_KRW 	= "KRW";
	public static final String PAY_TYPE_USD 	= "USD";
	public static final String PAY_TYPE_EUR 	= "EUR";
	
	public static final String PROFILE_GOLD = "../img/profile-goldspoon.jpg";
	public static final String PROFILE_NORMAL = "../img/profile-dummy.jpg";
	
	//푸시타입	
	public static final String TYPE_PNS_COUPON_YN = "CO";	//(쿠폰)
	public static final String TYPE_PNS_EVENT_YN = "EV";	//(이벤트)
	public static final String TYPE_PNS_NOTICE_YN = "NT";	//(공지사항)
	public static final String TYPE_PNS_UPDATE_YN = "UP";	//(업데이트)
	public static final String TYPE_PNS_NEW_POST_YN = "NP";	//(새게시글)
	public static final String TYPE_PNS_NEW_REPLY_YN = "NR";//(새댓글) > 게시글의 댓글(게시글상세)
	public static final String TYPE_PNS_NEW_CHAT_YN = "NC";	//(새채팅글)
	public static final String TYPE_PNS_CERT_RESULT = "CR";		//결제내역 인증결과
	public static final String TYPE_PNS_MISSION_CERT_RESULT = "MR";	//미션 인증결과
	public static final String TYPE_PNS_NEW_RE_REPLY_YN = "RR";	//(새대댓글) > 20161102 ycyu add > 댓글의 대댓글(도전과제상세)
}
