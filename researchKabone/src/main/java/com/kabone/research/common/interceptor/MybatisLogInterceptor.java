package com.kabone.research.common.interceptor;

import java.sql.Statement;
import java.util.Properties;

import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.session.ResultHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.kabone.research.common.log.MybatisQueryLog;


@Intercepts({
	@Signature(type=StatementHandler.class, method="update", args={Statement.class}),
	@Signature(type=StatementHandler.class, method="query", args={Statement.class, ResultHandler.class})
})
public class MybatisLogInterceptor implements Interceptor {
	
	private static final Logger logger = LoggerFactory.getLogger(MybatisLogInterceptor.class);

	@Override
	public Object intercept(Invocation invocation) throws Throwable {
		String sql = MybatisQueryLog.getSql(invocation);
        logger.debug("sql : {}\n", sql);
		return invocation.proceed(); 
	}
	
	@Override
	public Object plugin(Object target) {
		return Plugin.wrap(target, this);
	}
	
	@Override
	public void setProperties(Properties properties) {
	}
}
