package com.kabone.research.common.log.parameter;

import java.util.Map;

public class MapQueryParameter extends GeneralQueryParameter {

	public MapQueryParameter(Object parameter, String property) {
		super(parameter, property);
	}
	
	@Override
	public Object getParameter() {
		return ((Map<?, ?>) parameter ).get(property);
	}
}
