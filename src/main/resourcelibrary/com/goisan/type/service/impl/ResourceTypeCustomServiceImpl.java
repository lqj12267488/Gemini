package com.goisan.type.service.impl;

import com.goisan.type.dao.ResourceTypeCustomDao;
import com.goisan.type.service.ResourceTypeCustomService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ResourceTypeCustomServiceImpl implements ResourceTypeCustomService {
@Resource
private ResourceTypeCustomDao resourceTypeCustomDao;

    public List<BaseBean> getResourceTypeCustomList(BaseBean baseBean) {
        return resourceTypeCustomDao.getResourceTypeCustomList(baseBean);
    }

    public void saveResourceTypeCustom(BaseBean baseBean) {
        resourceTypeCustomDao.saveResourceTypeCustom(baseBean);
    }

    public BaseBean getResourceTypeCustomById(String id) {
        return resourceTypeCustomDao.getResourceTypeCustomById(id);
    }

    public void updateResourceTypeCustom(BaseBean baseBean) {
        resourceTypeCustomDao.updateResourceTypeCustom(baseBean);
    }

    public void delResourceTypeCustom(String id) {
        resourceTypeCustomDao.delResourceTypeCustom(id);
    }

    public String checkTypeCustom(String id){
        return resourceTypeCustomDao.checkTypeCustom(id);
    }
}
