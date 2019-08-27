package com.goisan.system.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface StudentParentRelationDao {

    List<BaseBean> getStudentParentRelationList(BaseBean baseBean);

    void saveStudentParentRelation(BaseBean baseBean);

    BaseBean getStudentParentRelationById(String id);

    void updateStudentParentRelation(BaseBean baseBean);

    void delStudentParentRelation(String id);

    void delRelationByParentid(String id);

    void delRoleByParentid(String id);

    List<BaseBean> checkStudentRelation(String studentId);
}
