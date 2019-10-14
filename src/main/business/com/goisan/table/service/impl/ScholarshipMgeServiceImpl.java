package com.goisan.table.service.impl;

import com.goisan.table.dao.ScholarshipMgeDao;
import com.goisan.table.service.ScholarshipMgeService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ScholarshipMgeServiceImpl implements ScholarshipMgeService {

    @Resource
    private ScholarshipMgeDao scholarshipMgeDao;

    @Override
    public List<BaseBean> getScholarshipMgeList(BaseBean baseBean) {
        return scholarshipMgeDao.getScholarshipMgeList(baseBean);
    }

    @Override
    public void saveScholarshipMge(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        scholarshipMgeDao.saveScholarshipMge(baseBean);
    }

    @Override
    public BaseBean getScholarshipMgeById(String id) {
        return scholarshipMgeDao.getScholarshipMgeById(id);
    }

    @Override
    public void updateScholarshipMge(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        scholarshipMgeDao.updateScholarshipMge(baseBean);
    }

    @Override
    public void delScholarshipMge(String id) {
        scholarshipMgeDao.delScholarshipMge(id);
    }
}
