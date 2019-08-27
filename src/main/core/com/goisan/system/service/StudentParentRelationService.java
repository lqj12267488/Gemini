package com.goisan.system.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface StudentParentRelationService {

    List<BaseBean> getStudentParentRelationList(BaseBean baseBean);

    void saveStudentParentRelation(BaseBean baseBean);

    BaseBean getStudentParentRelationById(String id);

    void updateStudentParentRelation(BaseBean baseBean);

    void delStudentParentRelation(String id);

    void delRelationByParentid(String id);

    void delRoleByParentid(String id);

    List<BaseBean> checkStudentRelation(String studentId);
}