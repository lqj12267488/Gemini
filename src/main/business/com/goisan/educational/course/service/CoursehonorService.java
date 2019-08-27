package com.goisan.educational.course.service;

import com.goisan.educational.course.bean.Coursehonor;

import java.util.List;

public interface CoursehonorService {
    List<Coursehonor> coursehonorAction(Coursehonor coursehonor);

    void deleteCoursehonorById(String id);

    Coursehonor getCoursehonorById(String id);

    void updateCoursehonorById(Coursehonor coursehonor);

    void insertCoursehonor(Coursehonor coursehonor);

    List<Coursehonor> coursehonorManageAction(Coursehonor coursehonor);

    void insertCoursehonorManage(Coursehonor coursehonor);

    void updateCoursehonorManageById(Coursehonor coursehonor);

    Coursehonor getCoursehonorManageById(String id);

    void deleteCoursehonorManageById(String id);

    List<Coursehonor> coursehonorCheckAction(Coursehonor coursehonor);

}
