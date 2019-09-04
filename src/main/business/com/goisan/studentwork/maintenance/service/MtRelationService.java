package com.goisan.studentwork.maintenance.service;

import com.goisan.studentwork.maintenance.bean.MtRelation;

import java.util.List;

/**
 * Created  By hanjie ON 2019/9/2
 */
public interface MtRelationService {

    List<MtRelation> getMRList(String relType);
    List<MtRelation> getMRListByRelId(MtRelation mtRelation);
    void insertMRDetail(MtRelation mtRelation);
    MtRelation getMRDetailById(String id);
    void updateMRDetailById(MtRelation mtRelation);
    void delMRDetailById(MtRelation mtRelation);
    void mtMRDetailById(MtRelation mtRelation);
}
