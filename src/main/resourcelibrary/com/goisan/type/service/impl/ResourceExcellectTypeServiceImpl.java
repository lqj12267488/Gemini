package com.goisan.type.service.impl;

import com.goisan.system.bean.BaseBean;
import com.goisan.type.dao.ResourceExcellectTypeDao;
import com.goisan.type.service.ResourceExcellectTypeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ResourceExcellectTypeServiceImpl implements ResourceExcellectTypeService {
    /*
    *  add by yang  liu
    */

    @Resource
    private ResourceExcellectTypeDao jpkResourceTypeDao;

    public List<BaseBean> getJPKResourceTypeList(BaseBean baseBean) {
        return jpkResourceTypeDao.getJPKResourceTypeList(baseBean);
    }

    public void saveJPKResourceType(BaseBean baseBean) {
        jpkResourceTypeDao.saveJPKResourceType(baseBean);
    }

    public BaseBean getJPKResourceTypeById(String id) {
        return jpkResourceTypeDao.getJPKResourceTypeById(id);
    }

    public void updateJPKResourceType(BaseBean baseBean) {
        jpkResourceTypeDao.updateJPKResourceType(baseBean);
    }

    public void delJPKResourceType(String id) {
        jpkResourceTypeDao.delJPKResourceType(id);
    }

    public String checkType(String id) {
        return jpkResourceTypeDao.checkType(id);
    }

        /*
    *  add by liu  end
    * */

    /*
    *  add by yang  start
    * */

    /*
    *  add by yang  end
    * */

    /*
    *  add by zhou  start
    * */

    /*
    *  add by zhou  end
    * */


}
