package com.goisan.system.service.impl;

import com.goisan.system.dao.StudentParentRelationDao;
import com.goisan.system.service.StudentParentRelationService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class StudentParentRelationServiceImpl implements StudentParentRelationService {
@Resource
private StudentParentRelationDao studentParentRelationDao;

    public List<BaseBean> getStudentParentRelationList(BaseBean baseBean) {
        return studentParentRelationDao.getStudentParentRelationList(baseBean);
    }

    public void saveStudentParentRelation(BaseBean baseBean) {
        studentParentRelationDao.saveStudentParentRelation(baseBean);
    }

    public BaseBean getStudentParentRelationById(String id) {
        return studentParentRelationDao.getStudentParentRelationById(id);
    }

    public void updateStudentParentRelation(BaseBean baseBean) {
        studentParentRelationDao.updateStudentParentRelation(baseBean);
    }

    public void delStudentParentRelation(String id) {
        studentParentRelationDao.delStudentParentRelation(id);
    }

    public void delRelationByParentid(String id) {
        studentParentRelationDao.delRelationByParentid(id);
    }

    public void delRoleByParentid(String id) {
        studentParentRelationDao.delRoleByParentid(id);
    }

    public List<BaseBean> checkStudentRelation(String studentId) {
        return studentParentRelationDao.checkStudentRelation(studentId);
    }
}
