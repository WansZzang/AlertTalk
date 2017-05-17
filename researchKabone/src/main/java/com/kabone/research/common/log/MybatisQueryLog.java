package com.kabone.research.common.log;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.plugin.Invocation;

import com.kabone.research.common.log.parameter.MybatisQueryParameters;
import com.kabone.research.common.log.parameter.QueryParameterVo;

public class MybatisQueryLog {
	private StatementHandler statementHandler;
	private List<Object> parameterList;
	private String sql;
	
	public static String getSql(Invocation invocation) {
		return new MybatisQueryLog(invocation).getSql();
	}

	private MybatisQueryLog(Invocation invocation) {
		this.statementHandler = (StatementHandler) invocation.getTarget();
		this.sql = statementHandler.getBoundSql().getSql();
		
		QueryParameterVo queryParameterVo = getQueryParameterVo();
		this.parameterList = MybatisQueryParameters.getParameterList(queryParameterVo);
	}
	
	private QueryParameterVo getQueryParameterVo() {
		QueryParameterVo queryParameterVo = new QueryParameterVo();
		queryParameterVo.setParameter(statementHandler.getParameterHandler().getParameterObject());
		queryParameterVo.setParameterMappings(statementHandler.getBoundSql().getParameterMappings());
		return queryParameterVo;
	}
	
	private String getSql() {
		if(parameterList.size() == 0) {
			return sql;
		}
		return getParametersInsertedSql();
	}
	
	private String getParametersInsertedSql() {
		StringBuffer buf = new StringBuffer();
		List<String> sqlList =  splitString(sql, '?');

		for(int i = 0;i<sqlList.size();i++) {
			buf.append(sqlList.get(i));
			
			if(parameterList.size() > i) {
				Object columnValue = parameterList.get(i);
				Object parameter = getParameterFromType(columnValue);
				buf.append(parameter);
			}
		}
		return buf.toString();
	}
	
	private List<String> splitString(String str, char token){
		List<String> list = new ArrayList<String>();
		int lastParmEnd = 0;
		for(int i = 0;i<str.length();i++) {
			if( str.charAt(i) == token) {
				list.add(str.substring(lastParmEnd, i));
				lastParmEnd = i + 1;
			}
		}
		list.add(str.substring(lastParmEnd, str.length()));
		return list;
	}
	
	private Object getParameterFromType(Object columnValue) {
		if (columnValue instanceof String) {
			return "'" + columnValue + "'";
		} else if (columnValue == null) {
			return "null";
		} else {
			return columnValue;
		}
	}
}
