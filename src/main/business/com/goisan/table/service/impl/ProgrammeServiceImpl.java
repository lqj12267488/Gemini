package com.goisan.table.service.impl;

import com.goisan.table.bean.Programme;
import com.goisan.table.dao.ProgrammeDao;
import com.goisan.table.service.ProgrammeService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ProgrammeServiceImpl implements ProgrammeService {

    @Resource
    private ProgrammeDao programmeDao;

    @Override
    public List<BaseBean> getProgrammeList(BaseBean baseBean) {
        return programmeDao.getProgrammeList(baseBean);
    }

    @Override
    public void saveProgramme(BaseBean baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        programmeDao.saveProgramme(baseBean);
    }

    @Override
    public Programme getProgrammeById(String id) {
        return programmeDao.getProgrammeById(id);
    }

    @Override
    public void updateProgramme(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        programmeDao.updateProgramme(baseBean);
    }

    @Override
    public void delProgramme(String id) {
        programmeDao.delProgramme(id);
    }
}
