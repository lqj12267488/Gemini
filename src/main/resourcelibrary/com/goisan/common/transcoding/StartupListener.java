package com.goisan.common.transcoding;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * 在项目启动时开启扫描数据库线程
 */
@Component
public class StartupListener implements ApplicationContextAware {

    @Resource
    private WordUtil wordUtil;

    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        wordUtil.init();
    }

}
