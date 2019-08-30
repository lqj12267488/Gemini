package com.goisan.studentwork.graduatearchivesaddress.service.impl;

import com.goisan.studentwork.graduatearchivesaddress.bean.Arcad;
import com.goisan.studentwork.graduatearchivesaddress.dao.ArcadDao;
import com.goisan.studentwork.graduatearchivesaddress.service.ArcadServcie;
import com.goisan.system.tools.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created  By hanjie ON 2019/8/29
 */
@Service
public class ArcadServcieImpl implements ArcadServcie {

    @Autowired
    private ArcadDao arcadDao;

    @Override
    public List<Arcad> getArcadList(Arcad arcad) {
        return arcadDao.getArcadList(arcad);
    }

    @Override
    public Arcad getArcadById(String arcadId) {
        return arcadDao.getArcadById(arcadId);
    }

    @Override
    public void insertArcad(Arcad arcad) {
        arcad.setCreator(CommonUtil.getPersonId());
        arcad.setChangeDept(CommonUtil.getDefaultDept());
        arcadDao.insertArcad(arcad);
    }

    @Override
    public void updateArcadById(Arcad arcad) {
        arcad.setChangeDept(CommonUtil.getDefaultDept());
        arcad.setChanger(CommonUtil.getPersonId());
        arcadDao.updateArcadById(arcad);
    }

    @Override
    public void delArcadById(Arcad arcad) {
        arcadDao.delArcadById(arcad);
    }
}
