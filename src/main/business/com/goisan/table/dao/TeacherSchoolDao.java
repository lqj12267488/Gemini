package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;
import com.goisan.table.bean.TeacherSchool;

import java.util.List;

public interface TeacherSchoolDao {

    List<TeacherSchool> getTeacherSchoolList(BaseBean baseBean);

    void saveTeacherSchool(BaseBean baseBean);

    BaseBean getTeacherSchoolById(String id);

    void updateTeacherSchool(BaseBean baseBean);

    void delTeacherSchool(String id);

    TeacherSchool selectTeacherById(String id);
}
