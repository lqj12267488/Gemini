package com.goisan.educational.expatriateteaching.service.impl;

import com.goisan.educational.expatriateteaching.bean.ExpatriateTeaching;
import com.goisan.educational.expatriateteaching.dao.ExpatriateTeachingDao;
import com.goisan.educational.expatriateteaching.service.ExpatriateTeachingService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ExpatriateTeachingServiceImpl implements ExpatriateTeachingService {
@Resource
private ExpatriateTeachingDao expatriateTeachingDao;

    public List<ExpatriateTeaching> getExpatriateTeachingList(ExpatriateTeaching expatriateTeaching) {
        return expatriateTeachingDao.getExpatriateTeachingList(expatriateTeaching);
    }

    public void saveExpatriateTeaching(BaseBean baseBean) {
        expatriateTeachingDao.saveExpatriateTeaching(baseBean);
    }

    public BaseBean getExpatriateTeachingById(String id) {
        return expatriateTeachingDao.getExpatriateTeachingById(id);
    }

    public void updateExpatriateTeaching(BaseBean baseBean) {
        expatriateTeachingDao.updateExpatriateTeaching(baseBean);
    }

    public void delExpatriateTeaching(String id) {
        expatriateTeachingDao.delExpatriateTeaching(id);
    }
}
