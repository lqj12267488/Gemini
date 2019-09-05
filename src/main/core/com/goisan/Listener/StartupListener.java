package com.goisan.Listener;

import com.goisan.system.bean.CommonBean;
import com.goisan.system.bean.Parameter;
import com.goisan.system.bean.PathBean;
import com.goisan.system.dao.ParameterDao;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ApplicationContextEvent;
import org.springframework.context.event.ContextClosedEvent;

import javax.annotation.Resource;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class StartupListener implements ApplicationListener<ApplicationContextEvent> {

    @Resource
    private ParameterDao parameterDao;

    @Override
    public void onApplicationEvent(ApplicationContextEvent event) {
        if (event != null && event instanceof ContextClosedEvent){
            System.out.println("----------destroy--------------");
        }else  if (event.getApplicationContext().getParent() == null) {
            System.out.println("----------init--------------");
            PathBean.BASEPATH = new File(event.getClass().getResource("/").getPath()).getParentFile().getParentFile().getPath();
            PathBean.init();
            init();
        }
    }

    private void init() {
        Map<String, String> map = new HashMap<String, String>();
        //系统设置
        List<Parameter> list = parameterDao.parameterInfo(null);
        for (Parameter p : list){
            map.put(p.getParametercode(), p.getParametervalue());
        }
        CommonBean.globalParamMap = map;
    }
}
