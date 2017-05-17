package com.kabone.research.common.log.parameter;

public abstract class GeneralQueryParameter {
	public Object parameter;
	public String property;
	
	public GeneralQueryParameter(Object parameter, String property) {
		this.parameter = parameter;
		this.property = property;
	}
	
	public abstract Object getParameter();
}
