package com.goisan.educational.course.dao;

import com.goisan.educational.course.bean.Coursehonor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CoursehonorDao {
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
