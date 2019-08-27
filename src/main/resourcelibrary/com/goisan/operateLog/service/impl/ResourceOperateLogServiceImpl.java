package com.goisan.operateLog.service.impl;

import com.goisan.operateLog.dao.ResourceOperateLogDao;
import com.goisan.operateLog.service.ResourceOperateLogService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ResourceOperateLogServiceImpl implements ResourceOperateLogService {
@Resource
private ResourceOperateLogDao resourceOperateLogDao;

    public List<BaseBean> getResourceOperateLogList(BaseBean baseBean) {
        return resourceOperateLogDao.getResourceOperateLogList(baseBean);
    }

    public void saveResourceOperateLog(BaseBean baseBean) {
        resourceOperateLogDao.saveResourceOperateLog(baseBean);
    }

    public BaseBean getResourceOperateLogById(String id) {
        return resourceOperateLogDao.getResourceOperateLogById(id);
    }

    public void updateResourceOperateLog(BaseBean baseBean) {
        resourceOperateLogDao.updateResourceOperateLog(baseBean);
    }

    public void delResourceOperateLog(String id) {
        resourceOperateLogDao.delResourceOperateLog(id);
    }
}
