package com.kabone.research.common.log.parameter;


public class EtcQueryParameter extends GeneralQueryParameter {

	public EtcQueryParameter(Object parameter, String property) {
		super(parameter, property);
	}
	
	@Override
	public Object getParameter() {
		return parameter;
	}

}
