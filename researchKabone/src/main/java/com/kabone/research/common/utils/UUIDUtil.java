package com.kabone.research.common.utils;

import java.util.UUID;

public class UUIDUtil {
	
	
    /**
	 * 시스템내에 유일한 키값으로 사용할 id를 반환한다. <br>
	 * ex) UUIDUtil.getUUID() - UUID 반환
	 * @return String - UUID + yyMMdd   32+6=38자리
	 */
    public static String getUUID() {
    	
       	return (UUID.randomUUID().toString().replaceAll("-", "") + DateUtil.getCurrentTimeShortFormat());
    }
}
