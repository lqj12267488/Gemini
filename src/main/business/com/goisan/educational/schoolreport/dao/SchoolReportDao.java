package com.goisan.educational.schoolreport.dao;

import com.goisan.educational.schoolreport.bean.SchoolReport;
import com.goisan.system.bean.ClassBean;
import com.goisan.system.bean.RoleEmpDeptRelation;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface SchoolReportDao {
    List<SchoolReport> getSchoolReportList(SchoolReport schoolReport);

    List<SchoolReport> getStudentInfo(SchoolReport schoolReport);

    List<RoleEmpDeptRelation> getRoleByPersonId(String id);

    List<ClassBean> getClassBeanByPersonId(String id);

    List<String> getStudentIds(@Param("deptId") String deptId, @Param("classId") String classId, @Param("majorId") String majorId
            , @Param("studentName") String studentName);
}
