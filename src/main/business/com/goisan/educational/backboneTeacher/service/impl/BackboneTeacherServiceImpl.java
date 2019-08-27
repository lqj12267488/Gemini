package com.goisan.educational.backboneTeacher.service.impl;

import com.goisan.educational.backboneTeacher.bean.BackboneTeacher;
import com.goisan.educational.backboneTeacher.dao.BackboneTeacherDao;
import com.goisan.educational.backboneTeacher.service.BackboneTeacherService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class BackboneTeacherServiceImpl implements BackboneTeacherService {
    @Resource
    private BackboneTeacherDao backboneTeacherDao;
    public List<BackboneTeacher> backboneTeacherAction(BackboneTeacher backboneTeacher){ return backboneTeacherDao.backboneTeacherAction(backboneTeacher);}
    public void deleteBackboneTeacherById(String id){ backboneTeacherDao.deleteBackboneTeacherById(id);}
    public BackboneTeacher getBackboneTeacherById(String id){ return backboneTeacherDao.getBackboneTeacherById(id); }
    public void updateBackboneTeacherById(BackboneTeacher backboneTeacher){ backboneTeacherDao.updateBackboneTeacherById(backboneTeacher);}
    public void insertBackboneTeacher(BackboneTeacher backboneTeacher){ backboneTeacherDao.insertBackboneTeacher(backboneTeacher);}
}
