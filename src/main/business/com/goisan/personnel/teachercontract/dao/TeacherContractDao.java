package com.goisan.personnel.teachercontract.dao;

import com.goisan.personnel.teachercontract.bean.TeacherContract;
import com.goisan.system.bean.BaseBean;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TeacherContractDao {

    List<TeacherContract> getTeacherContractList(BaseBean baseBean);

    void saveTeacherContract(BaseBean baseBean);

    BaseBean getTeacherContractByPersonId(@Param("personId") String personId, @Param("deptId") String deptId);

    BaseBean getTeachConByPersonId(@Param("personId") String personId);

    void updateTeacherContract(BaseBean baseBean);

    void delTeacherContract(String personId);

}
