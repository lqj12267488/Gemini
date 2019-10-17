package com.goisan.table.service.impl;

import com.goisan.table.bean.CourtyardName;
import com.goisan.table.dao.CourtyardNameDao;
import com.goisan.table.service.CourtyardNameService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CourtyardNameServiceImpl implements CourtyardNameService {

    @Resource
    private CourtyardNameDao courtyardNameDao;

    @Override
    public List<CourtyardName> getCourtyardNameList(CourtyardName baseBean) {
        return courtyardNameDao.getCourtyardNameList(baseBean);
    }

    @Override
    public void saveCourtyardName(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        courtyardNameDao.saveCourtyardName(baseBean);
    }

    @Override
    public BaseBean getCourtyardNameById(String id) {
        return courtyardNameDao.getCourtyardNameById(id);
    }

    @Override
    public void updateCourtyardName(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        courtyardNameDao.updateCourtyardName(baseBean);
    }

    @Override
    public void delCourtyardName(String id) {
        courtyardNameDao.delCourtyardName(id);
    }
}
