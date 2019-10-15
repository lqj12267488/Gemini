package com.goisan.table.service.impl;

import com.goisan.table.bean.TeacherSchool;
import com.goisan.table.dao.TeacherSchoolDao;
import com.goisan.table.service.TeacherSchoolService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.UUID;

@Service
public class TeacherSchoolServiceImpl implements TeacherSchoolService {

    @Resource
    private TeacherSchoolDao teacherSchoolDao;

    @Override
    public List<TeacherSchool> getTeacherSchoolList(BaseBean baseBean) {
        return teacherSchoolDao.getTeacherSchoolList(baseBean);
    }

    @Override
    public void saveTeacherSchool(TeacherSchool teacherSchool) {
        teacherSchool.setCreateDept(CommonUtil.getDefaultDept());
        teacherSchool.setCreator(CommonUtil.getPersonId());
        teacherSchool.setId(UUID.randomUUID().toString());
        teacherSchoolDao.saveTeacherSchool(teacherSchool);
    }

    @Override
    public BaseBean getTeacherSchoolById(String id) {
        return teacherSchoolDao.getTeacherSchoolById(id);
    }

    @Override
    public void updateTeacherSchool(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());
        teacherSchoolDao.updateTeacherSchool(baseBean);
    }

    @Override
    public void delTeacherSchool(String id) {
        teacherSchoolDao.delTeacherSchool(id);
    }

    @Override
    public TeacherSchool selectTeacherById(String id) {
        return teacherSchoolDao.selectTeacherById(id);
    }
}
