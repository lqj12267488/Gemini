package com.goisan.table.service.impl;

import com.goisan.table.bean.Volunteers;
import com.goisan.table.dao.VolunteersDao;
import com.goisan.table.service.VolunteersService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class VolunteersServiceImpl implements VolunteersService {

    @Resource
    private VolunteersDao volunteersDao;

    @Override
    public List<BaseBean> getVolunteersList(BaseBean baseBean) {
        return volunteersDao.getVolunteersList(baseBean);
    }

    @Override
    public void saveVolunteers(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        volunteersDao.saveVolunteers(baseBean);
    }

    @Override
    public Volunteers getVolunteersById(String id) {
        return volunteersDao.getVolunteersById(id);
    }

    @Override
    public void updateVolunteers(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        volunteersDao.updateVolunteers(baseBean);
    }

    @Override
    public void delVolunteers(String id) {
        volunteersDao.delVolunteers(id);
    }
}
