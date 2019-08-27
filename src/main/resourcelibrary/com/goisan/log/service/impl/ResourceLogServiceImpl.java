package com.goisan.log.service.impl;

import com.goisan.log.dao.ResourceLogDao;
import com.goisan.log.service.ResourceLogService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ResourceLogServiceImpl implements ResourceLogService {
@Resource
private ResourceLogDao resourceLogDao;

    public List<BaseBean> getResourceLogList(BaseBean baseBean) {
        return resourceLogDao.getResourceLogList(baseBean);
    }

    public List<BaseBean> getPrivateResourceLogList(BaseBean baseBean) {
        return resourceLogDao.getPrivateResourceLogList(baseBean);
    }

    public void saveResourceLog(BaseBean baseBean) {
        resourceLogDao.saveResourceLog(baseBean);
    }

    public BaseBean getResourceLogById(String id) {
        return resourceLogDao.getResourceLogById(id);
    }

    public void updateResourceLog(BaseBean baseBean) {
        resourceLogDao.updateResourceLog(baseBean);
    }

    public void delResourceLog(String id) {
        resourceLogDao.delResourceLog(id);
    }

    public void delStatistics() {
        resourceLogDao.delStatistics();
    }

    public void insertStatistics() {
        resourceLogDao.insertStatistics ();
    }
}
