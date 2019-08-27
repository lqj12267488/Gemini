package com.goisan.educational.course.service;

import com.goisan.educational.course.bean.Teacherhonor;

import java.util.List;

public interface TeacherhonorService {

    List<Teacherhonor> getTeacherhonorByDeptAndTeacherId(String deptId, String teacherId,String id);

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
