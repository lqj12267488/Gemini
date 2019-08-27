package com.goisan.crawler.service.impl;

import com.goisan.crawler.bean.SensiWord;
import com.goisan.crawler.dao.SensiTypeDao;
import com.goisan.crawler.service.SensiTypeService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SensiTypeServiceImpl implements SensiTypeService {
@Resource
private SensiTypeDao sensiTypeDao;

    public List<BaseBean> getSensiTypeList(BaseBean baseBean) {
        return sensiTypeDao.getSensiTypeList(baseBean);
    }

    public void saveSensiType(BaseBean baseBean) {
        sensiTypeDao.saveSensiType(baseBean);
    }

    public BaseBean getSensiTypeById(String id) {
        return sensiTypeDao.getSensiTypeById(id);
    }

    public void updateSensiType(BaseBean baseBean) {
        sensiTypeDao.updateSensiType(baseBean);
    }

    public void delSensiType(String id) {
        sensiTypeDao.delSensiType(id);
    }

    @Override
    public List<SensiWord> getSensiWordBySensiTypeId(String id) {
        return sensiTypeDao.getSensiWordBySensiTypeId(id);
    }
}
