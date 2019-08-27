package com.goisan.educational.course.dao;

import com.goisan.educational.course.bean.Teacherhonor;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TeacherhonorDao {

    List<Teacherhonor>getTeacherhonorByDeptAndTeacherId(@Param("deptId") String deptId, @Param("teacherId") String teacherId,@Param("id") String id);

    List<Teacherhonor> teacherhonorAction(Teacherhonor teacherhonor);

    void deleteTeacherhonorById(String id);

    Teacherhonor getTeacherhonorById(String id);

    void updateTeacherhonorById(Teacherhonor teacherhonor);

    void insertTeacherhonor(Teacherhonor teacherhonor);

    List<Teacherhonor> teacherhonorManageAction(Teacherhonor teacherhonor);

    void insertTeacherhonorManage(Teacherhonor teacherhonor);

    void updateTeacherhonorManageById(Teacherhonor teacherhonor);

    Teacherhonor getTeacherhonorManageById(String id);

    void deleteTeacherhonorManageById(String id);

    List<Teacherhonor> teacherhonorCheckAction(Teacherhonor teacherhonor);




}
