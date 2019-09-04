package com.goisan.studentwork.maintenance.service.impl;

import com.goisan.studentwork.maintenance.bean.MtRelation;
import com.goisan.studentwork.maintenance.dao.MtRelationDao;
import com.goisan.studentwork.maintenance.service.MtRelationService;
import com.goisan.system.tools.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created  By hanjie ON 2019/9/2
 */
@Service
public class MtRelationServiceImpl implements MtRelationService {

    @Autowired
    private MtRelationDao mtRelationDao;

    @Override
    public List<MtRelation> getMRList(String relType) {
        if ("1".equals(relType)){
            return mtRelationDao.getMRClassList();
        }else {
            return mtRelationDao.getMRDormList();
        }
    }

    @Override
    public List<MtRelation> getMRListByRelId(MtRelation mtRelation) {
        return mtRelationDao.getMRListByRelId(mtRelation);
    }

    @Override
    public void insertMRDetail(MtRelation mtRelation) {
        mtRelation.setCreator(CommonUtil.getPersonId());
        mtRelation.setCreateDept(CommonUtil.getDefaultDept());
        mtRelationDao.insertMRDetail(mtRelation);
    }

    @Override
    public MtRelation getMRDetailById(String id) {
        return mtRelationDao.getMRDetailById(id);
    }

    @Override
    public void updateMRDetailById(MtRelation mtRelation) {
        mtRelation.setChanger(CommonUtil.getPersonId());
        mtRelation.setChangeDept(CommonUtil.getDefaultDept());

        mtRelationDao.updateMRDetailById(mtRelation);
    }

    @Override
    public void delMRDetailById(MtRelation mtRelation) {
        mtRelation.setChanger(CommonUtil.getPersonId());
        mtRelation.setChangeDept(CommonUtil.getDefaultDept());
        mtRelationDao.delMRDetailById(mtRelation);
    }

    @Override
    public void mtMRDetailById(MtRelation mtRelation) {
        mtRelation.setChanger(CommonUtil.getPersonId());
        mtRelation.setChangeDept(CommonUtil.getDefaultDept());
        mtRelationDao.mtMRDetailById(mtRelation);
    }
}
