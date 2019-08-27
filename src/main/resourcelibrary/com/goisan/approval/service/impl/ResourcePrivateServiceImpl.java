package com.goisan.approval.service.impl;

import com.goisan.approval.bean.ResourcePrivate;
import com.goisan.approval.dao.ResourcePrivateDao;
import com.goisan.approval.service.ResourcePrivateService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.Files;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ResourcePrivateServiceImpl implements ResourcePrivateService {
    @Resource
    private ResourcePrivateDao resourcePrivateDao;

    public List<ResourcePrivate> getResourcePrivateList(ResourcePrivate resourcePrivate) {
        return resourcePrivateDao.getResourcePrivateList(resourcePrivate);
    }

    public void saveResourcePrivate(ResourcePrivate resourcePrivate) {
        resourcePrivateDao.saveResourcePrivate(resourcePrivate);
    }

    public ResourcePrivate getResourcePrivateById(String id) {
        return resourcePrivateDao.getResourcePrivateById(id);
    }

    public void updateResourcePrivate(ResourcePrivate resourcePrivate) {
        resourcePrivateDao.updateResourcePrivate(resourcePrivate);
    }

    public void updatePrivateFlag(ResourcePrivate resourcePrivate) {
        resourcePrivateDao.updatePrivateFlag(resourcePrivate);
    }

    public void delResourcePrivate(String id) {
        resourcePrivateDao.delResourcePrivate(id);
    }

    public List<ResourcePrivate> myResourceRecycleList(ResourcePrivate resourcePrivate) {
        return resourcePrivateDao.myResourceRecycleList(resourcePrivate);
    }

    public void backResourceRecycle(String id) {
        resourcePrivateDao.backResourceRecycle(id);
    }

    public void delResourceRecycle(String id){
        resourcePrivateDao.delResourceRecycle(id);
    }

    public void delResourceURL(String id){
        resourcePrivateDao.delResourceURL(id);
    }

    public Files selectFileURL(String id){
        return resourcePrivateDao.selectFileURL(id);
    }
}
