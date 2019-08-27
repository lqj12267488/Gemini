package com.goisan.type.service.impl;

import com.goisan.type.dao.ResourceTypeSubjectDao;
import com.goisan.type.service.ResourceTypeSubjectService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ResourceTypeSubjectServiceImpl implements ResourceTypeSubjectService {
@Resource
private ResourceTypeSubjectDao resourceTypeSubjectDao;

    public List<BaseBean> getResourceTypeSubjectList(BaseBean baseBean) {
        return resourceTypeSubjectDao.getResourceTypeSubjectList(baseBean);
    }

    public void saveResourceTypeSubject(BaseBean baseBean) {
        resourceTypeSubjectDao.saveResourceTypeSubject(baseBean);
    }

    public BaseBean getResourceTypeSubjectById(String id) {
        return resourceTypeSubjectDao.getResourceTypeSubjectById(id);
    }

    public void updateResourceTypeSubject(BaseBean baseBean) {
        resourceTypeSubjectDao.updateResourceTypeSubject(baseBean);
    }

    public void delResourceTypeSubject(String id) {
        resourceTypeSubjectDao.delResourceTypeSubject(id);
    }

    public String checkTypeSubject(String id) {
        return resourceTypeSubjectDao.checkTypeSubject(id);
    }
}
