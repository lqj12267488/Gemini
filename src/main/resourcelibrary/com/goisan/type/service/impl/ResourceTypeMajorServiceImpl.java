package com.goisan.type.service.impl;

import com.goisan.type.dao.ResourceTypeMajorDao;
import com.goisan.type.service.ResourceTypeMajorService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ResourceTypeMajorServiceImpl implements ResourceTypeMajorService {
@Resource
private ResourceTypeMajorDao resourceTypeMajorDao;

    public List<BaseBean> getResourceTypeMajorList(BaseBean baseBean) {
        return resourceTypeMajorDao.getResourceTypeMajorList(baseBean);
    }

    public void saveResourceTypeMajor(BaseBean baseBean) {
        resourceTypeMajorDao.saveResourceTypeMajor(baseBean);
    }

    public BaseBean getResourceTypeMajorById(String id) {
        return resourceTypeMajorDao.getResourceTypeMajorById(id);
    }

    public void updateResourceTypeMajor(BaseBean baseBean) {
        resourceTypeMajorDao.updateResourceTypeMajor(baseBean);
    }

    public void delResourceTypeMajor(String id) {
        resourceTypeMajorDao.delResourceTypeMajor(id);
    }

    public String checkTypeMajor(String id) {
        return resourceTypeMajorDao.checkTypeMajor(id);
    }


}
