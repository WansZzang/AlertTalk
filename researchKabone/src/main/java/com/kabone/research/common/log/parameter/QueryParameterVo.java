package com.kabone.research.common.log.parameter;

import java.util.List;

import org.apache.ibatis.mapping.ParameterMapping;

public class QueryParameterVo {
	Object parameter;
	List<ParameterMapping> parameterMappings;
	
	public Object getParameter() {
		return parameter;
	}
	public void setParameter(Object parameter) {
		this.parameter = parameter;
	}
	public List<ParameterMapping> getParameterMappings() {
		return parameterMappings;
	}
	public void setParameterMappings(List<ParameterMapping> parameterMappings) {
		this.parameterMappings = parameterMappings;
	}
	
}
