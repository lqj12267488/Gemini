package com.goisan.collection.service.impl;

import com.goisan.collection.dao.ResourceCollectionDao;
import com.goisan.collection.service.ResourceCollectionService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ResourceCollectionServiceImpl implements ResourceCollectionService {
@Resource
private ResourceCollectionDao resourceCollectionDao;

    public List<BaseBean> getResourceCollectionList(BaseBean baseBean) {
        return resourceCollectionDao.getResourceCollectionList(baseBean);
    }

    public void saveResourceCollection(BaseBean baseBean) {
        resourceCollectionDao.saveResourceCollection(baseBean);
    }

    public BaseBean getResourceCollectionById(String id) {
        return resourceCollectionDao.getResourceCollectionById(id);
    }

    public void updateResourceCollection(BaseBean baseBean) {
        resourceCollectionDao.updateResourceCollection(baseBean);
    }

    public void delResourceCollection(String id) {
        resourceCollectionDao.delResourceCollection(id);
    }
}
