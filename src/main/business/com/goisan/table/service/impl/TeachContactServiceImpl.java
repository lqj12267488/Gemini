package com.goisan.table.service.impl;

import com.goisan.table.dao.TeachContactDao;
import com.goisan.table.service.TeachContactService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class TeachContactServiceImpl implements TeachContactService {

    @Resource
    private TeachContactDao teachContactDao;

    @Override
    public List<BaseBean> getTeachContactList(BaseBean baseBean) {
        return teachContactDao.getTeachContactList(baseBean);
    }

    @Override
    public void saveTeachContact(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        teachContactDao.saveTeachContact(baseBean);
    }

    @Override
    public BaseBean getTeachContactById(String id) {
        return teachContactDao.getTeachContactById(id);
    }

    @Override
    public void updateTeachContact(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        teachContactDao.updateTeachContact(baseBean);
    }

    @Override
    public void delTeachContact(String id) {
        teachContactDao.delTeachContact(id);
    }
}
