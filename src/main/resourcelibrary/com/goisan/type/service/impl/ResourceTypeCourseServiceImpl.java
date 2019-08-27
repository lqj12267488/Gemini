package com.goisan.type.service.impl;

import com.goisan.type.dao.ResourceTypeCourseDao;
import com.goisan.type.service.ResourceTypeCourseService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ResourceTypeCourseServiceImpl implements ResourceTypeCourseService {
@Resource
private ResourceTypeCourseDao resourceTypeCourseDao;

    public List<BaseBean> getResourceTypeCourseList(BaseBean baseBean) {
        return resourceTypeCourseDao.getResourceTypeCourseList(baseBean);
    }

    public void saveResourceTypeCourse(BaseBean baseBean) {
        resourceTypeCourseDao.saveResourceTypeCourse(baseBean);
    }

    public BaseBean getResourceTypeCourseById(String id) {
        return resourceTypeCourseDao.getResourceTypeCourseById(id);
    }

    public void updateResourceTypeCourse(BaseBean baseBean) {
        resourceTypeCourseDao.updateResourceTypeCourse(baseBean);
    }

    public void delResourceTypeCourse(String id) {
        resourceTypeCourseDao.delResourceTypeCourse(id);
    }

    public String checkTypeCourse(String id) {
        return resourceTypeCourseDao.checkTypeCourse(id);
    }
}
