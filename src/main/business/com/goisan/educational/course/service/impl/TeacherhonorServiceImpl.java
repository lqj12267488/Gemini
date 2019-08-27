package com.goisan.educational.course.service.impl;


import com.goisan.educational.course.bean.Teacherhonor;

import com.goisan.educational.course.dao.TeacherhonorDao;

import com.goisan.educational.course.service.TeacherhonorService;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class TeacherhonorServiceImpl implements TeacherhonorService {

    @Resource
    private TeacherhonorDao teacherhonorDao;

    @Override
    public List<Teacherhonor> getTeacherhonorByDeptAndTeacherId(String deptId, String teacherId,String id) {
        return this.teacherhonorDao.getTeacherhonorByDeptAndTeacherId(deptId, teacherId, id);
    }

    @Override
    public List<Teacherhonor> teacherhonorAction(Teacherhonor teacherhonor) {
        return teacherhonorDao.teacherhonorAction(teacherhonor);
    }

    @Override
    public void deleteTeacherhonorById(String id) {
        teacherhonorDao.deleteTeacherhonorById(id);
    }

    @Override
    public Teacherhonor getTeacherhonorById(String id) {
        return teacherhonorDao.getTeacherhonorById(id);
    }

    @Override
    public void updateTeacherhonorById(Teacherhonor teacherhonor) {
        teacherhonorDao.updateTeacherhonorById(teacherhonor);
    }

    @Override
    public void insertTeacherhonor(Teacherhonor teacherhonor) {
        teacherhonorDao.insertTeacherhonor(teacherhonor);
    }



    public List<Teacherhonor> teacherhonorManageAction(Teacherhonor teacherhonor) {
        return teacherhonorDao.teacherhonorManageAction(teacherhonor);
    }

    @Override
    public void insertTeacherhonorManage(Teacherhonor teacherhonor) {
        teacherhonorDao.insertTeacherhonorManage(teacherhonor);

    }

    @Override
    public void updateTeacherhonorManageById(Teacherhonor teacherhonor) {
        teacherhonorDao.updateTeacherhonorManageById(teacherhonor);
    }

    @Override
    public Teacherhonor getTeacherhonorManageById(String id) {
        return teacherhonorDao.getTeacherhonorManageById(id);
    }

    @Override
    public void deleteTeacherhonorManageById(String id) {
        teacherhonorDao.deleteTeacherhonorManageById(id);
    }

    public List<Teacherhonor> teacherhonorCheckAction(Teacherhonor teacherhonor) {
        return teacherhonorDao.teacherhonorCheckAction(teacherhonor);
    }



}
