package com.goisan.studentwork.maintenance.service.impl;

import com.goisan.studentwork.maintenance.bean.MtType;
import com.goisan.studentwork.maintenance.dao.MtTypeDao;
import com.goisan.studentwork.maintenance.service.MtTypeService;
import com.goisan.system.tools.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created  By hanjie ON 2019/9/2
 */
@Service
public class MtTypeServiceImpl implements MtTypeService {

    @Autowired
    private MtTypeDao mtTypeDao;

    @Override
    public List<MtType> getMtTypeList(MtType mtType) {
        return mtTypeDao.getMtTypeList(mtType);
    }

    @Override
    public MtType getMtTypeById(MtType mtType) {
        return mtTypeDao.getMtTypeById(mtType);
    }

    @Override
    public void insertMtType(MtType mtType) {
            mtType.setCreator(CommonUtil.getPersonId());
            mtType.setCreateDept(CommonUtil.getDefaultDept());
            mtTypeDao.insertMtType(mtType);
    }

    @Override
    public void updateMtTypeById(MtType mtType) {
            mtType.setChanger(CommonUtil.getPersonId());
            mtType.setChangeDept(CommonUtil.getDefaultDept());
            mtTypeDao.updateMtTypeById(mtType);
    }

    @Override
    public void delMtTypeById(MtType mtType) {
        mtType.setChanger(CommonUtil.getPersonId());
        mtType.setChangeDept(CommonUtil.getDefaultDept());
        mtTypeDao.delMtTypeById(mtType);
    }


}
