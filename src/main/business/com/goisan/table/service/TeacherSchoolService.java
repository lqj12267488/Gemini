package com.goisan.table.service;

import com.goisan.system.bean.BaseBean;
import com.goisan.table.bean.TeacherSchool;

import java.util.List;

public interface TeacherSchoolService {

    List<TeacherSchool> getTeacherSchoolList(BaseBean baseBean);

    void saveTeacherSchool(TeacherSchool teacherSchool);

    BaseBean getTeacherSchoolById(String id);

    void updateTeacherSchool(BaseBean baseBean);

    void delTeacherSchool(String id);

    TeacherSchool selectTeacherById(String id);
}