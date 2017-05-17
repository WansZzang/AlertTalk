package com.kabone.research.common.log.parameter;

import org.apache.commons.beanutils.PropertyUtils;

public class PropertiyQueryParameter extends GeneralQueryParameter {

	public PropertiyQueryParameter(Object parameter, String property) {
		super(parameter, property);
	}
	
	@Override
	public Object getParameter() {
		try {
			return PropertyUtils.getProperty(parameter, property);
		} catch (Exception e) {
			return "?";
		}
	}

}
