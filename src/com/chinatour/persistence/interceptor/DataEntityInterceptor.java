package com.chinatour.persistence.interceptor;

import com.chinatour.entity.BaseEntity;
import com.chinatour.entity.BaseUuidEntity;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.SqlCommandType;
import org.apache.ibatis.plugin.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Date;
import java.util.Properties;

/**
 * MyBatis 实体拦截器
 * 在MyBatis新增数据或者修改数据时，可自动添加CreateDate，ModifyDate
 * Created by XuXuebin on 2014-09-04.
 */
@Intercepts(value = {@Signature(type = Executor.class, method = "update", args = {MappedStatement.class, Object.class})})
public class DataEntityInterceptor implements Interceptor {

    private Logger logger = LoggerFactory.getLogger(DataEntityInterceptor.class);

    private Properties properties;

    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        MappedStatement mappedStatement = (MappedStatement) invocation.getArgs()[0];
        SqlCommandType sqlCommandType = mappedStatement.getSqlCommandType();
        BaseEntity baseEntity = invocation.getArgs()[1] instanceof BaseEntity ? (BaseEntity) invocation.getArgs()[1] : null;
        BaseUuidEntity baseUuidEntity = null;
        Date date = new Date();
        logger.info("");
        if (baseEntity != null) {
            baseUuidEntity = invocation.getArgs()[1] instanceof BaseUuidEntity ? (BaseUuidEntity) invocation.getArgs()[1] : null;
        }
        if (SqlCommandType.INSERT.equals(sqlCommandType)) {
            if (baseEntity != null) {
                baseEntity.setCreateDate(date);
                baseEntity.setModifyDate(date);
            } else if (baseUuidEntity != null) {
                baseUuidEntity.setCreateDate(date);
                baseUuidEntity.setModifyDate(date);
            }
        } else if (SqlCommandType.UPDATE.equals(sqlCommandType)) {
            if (baseEntity != null) {
                baseEntity.setModifyDate(date);
            } else if (baseUuidEntity != null) {
                baseUuidEntity.setModifyDate(date);
            }
        }
        return invocation.proceed();
    }

    @Override
    public Object plugin(Object o) {
        return Plugin.wrap(o, this);
    }

    @Override
    public void setProperties(Properties properties) {
        this.properties = properties;
    }
}
