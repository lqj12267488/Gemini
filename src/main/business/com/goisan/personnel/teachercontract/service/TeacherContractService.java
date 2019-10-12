package com.goisan.personnel.teachercontract.service;

import com.goisan.personnel.teachercontract.bean.TeacherContract;
import com.goisan.system.bean.BaseBean;

import java.util.List;
import java.util.Map;

public interface TeacherContractService {

    List<TeacherContract> getTeacherContractList(TeacherContract teacherContract);

    void saveTeacherContract(BaseBean baseBean);

    BaseBean getTeacherContractByPersonId(String personId,String deptId);

    void updateTeacherContract(TeacherContract teacherContract);

    TeacherContract getMaxTeachConByPersonId(String personId);
}