package com.goisan.educational.course.service.impl;

import com.goisan.educational.course.bean.Coursehonor;
import com.goisan.educational.course.dao.CoursehonorDao;
import com.goisan.educational.course.service.CoursehonorService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CoursehonorServiceImpl implements CoursehonorService{
    @Resource
    private CoursehonorDao coursehonorDao;

    public List<Coursehonor> coursehonorAction(Coursehonor coursehonor){
        return coursehonorDao.coursehonorAction(coursehonor);
    }

    public void deleteCoursehonorById(String id){
        coursehonorDao.deleteCoursehonorById(id);
    }

    public Coursehonor getCoursehonorById(String id){
        return coursehonorDao.getCoursehonorById(id);
    }

    public void updateCoursehonorById(Coursehonor coursehonor){
        coursehonorDao.updateCoursehonorById(coursehonor);
    }

    public void insertCoursehonor(Coursehonor coursehonor){
        coursehonorDao.insertCoursehonor(coursehonor);
    }

    @Override
    public List<Coursehonor> coursehonorManageAction(Coursehonor coursehonor) {
        return coursehonorDao.coursehonorManageAction(coursehonor);
    }


    @Override
    public void insertCoursehonorManage(Coursehonor coursehonor) {
        coursehonorDao.insertCoursehonorManage(coursehonor);
    }

    @Override
    public void updateCoursehonorManageById(Coursehonor coursehonor) {
        coursehonorDao.updateCoursehonorManageById(coursehonor);
    }

    @Override
    public Coursehonor getCoursehonorManageById(String id) {
        return coursehonorDao.getCoursehonorManageById(id);
    }

    @Override
    public void deleteCoursehonorManageById(String id) {
        coursehonorDao.deleteCoursehonorManageById(id);
    }

    @Override
    public List<Coursehonor> coursehonorCheckAction(Coursehonor coursehonor) {
        return coursehonorDao.coursehonorCheckAction(coursehonor);
    }


}
