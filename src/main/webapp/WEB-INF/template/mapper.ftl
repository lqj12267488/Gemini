<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${packageName}.dao.${beanName}Dao">
    <select id="get${beanName?cap_first}List"
            parameterType="${packageName}.bean.${beanName}"
            resultType="${packageName}.bean.${beanName}">
        ${select}
    </select>
    <insert id="save${beanName?cap_first}" parameterType="${packageName}.bean.${beanName}">
        ${insert}
    </insert>
    <select id="get${beanName?cap_first}ById" parameterType="java.lang.String"
            resultType="${packageName}.bean.${beanName}">
        select * from ${tableName} where ${primary} = ${r'#{id}'}
    </select>
    <update id="update${beanName?cap_first}" parameterType="${packageName}.bean.${beanName}">
        ${update} where ${primary} = ${r'#{' + primary + '}'}
    </update>
    <delete id="del${beanName?cap_first}" parameterType="java.lang.String">
        delete from ${tableName} where ${primary} = ${r'#{id}'}
    </delete>
</mapper>