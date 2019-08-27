package com.goisan.system.service.impl;

import com.goisan.system.dao.ClassCadreDao;
import com.goisan.system.service.ClassCadreService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ClassCadreServiceImpl implements ClassCadreService {
@Resource
private ClassCadreDao classCadreDao;

    public List<BaseBean> getClassCadreList(BaseBean baseBean) {
        return classCadreDao.getClassCadreList(baseBean);
    }

    public void saveClassCadre(BaseBean baseBean) {
        classCadreDao.saveClassCadre(baseBean);
    }

    public BaseBean getClassCadreById(String id) {
        return classCadreDao.getClassCadreById(id);
    }

    public void updateClassCadre(BaseBean baseBean) {
        classCadreDao.updateClassCadre(baseBean);
    }

    public void delClassCadre(String id) {
        classCadreDao.delClassCadre(id);
    }
}
