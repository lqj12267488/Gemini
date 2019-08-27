package com.goisan.educational.backboneTeacher.dao;

import com.goisan.educational.backboneTeacher.bean.BackboneTeacher;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BackboneTeacherDao {
    List<BackboneTeacher> backboneTeacherAction(BackboneTeacher backboneTeacher);
    void deleteBackboneTeacherById(String id);
    BackboneTeacher getBackboneTeacherById(String id);
    void updateBackboneTeacherById(BackboneTeacher backboneTeacher);
    void insertBackboneTeacher(BackboneTeacher backboneTeacher);
}
