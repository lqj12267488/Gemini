package com.goisan.studentwork.maintenance.dao;

import com.goisan.studentwork.maintenance.bean.MtRelation;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created  By hanjie ON 2019/9/2
 */
@Repository
public interface MtRelationDao {
   List<MtRelation> getMRClassList(MtRelation mtRelation);
   List<MtRelation> getMRDormList(MtRelation mtRelation);
   List<MtRelation> getMRListByRelId(MtRelation mtRelation);
  MtRelation getMRDetailById(String id);
   void insertMRDetail(MtRelation mtRelation);
   void updateMRDetailById(MtRelation mtRelation);
  void delMRDetailById(MtRelation mtRelation);
   void mtMRDetailById(MtRelation mtRelation);
}
