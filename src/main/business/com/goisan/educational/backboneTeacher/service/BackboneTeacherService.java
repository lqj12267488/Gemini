package com.goisan.educational.backboneTeacher.service;

import com.goisan.educational.backboneTeacher.bean.BackboneTeacher;

import java.util.List;

public interface BackboneTeacherService {
    List<BackboneTeacher> backboneTeacherAction(BackboneTeacher backboneTeacher);
    void deleteBackboneTeacherById(String id);
    BackboneTeacher getBackboneTeacherById(String id);
    void updateBackboneTeacherById(BackboneTeacher backboneTeacher);
    void insertBackboneTeacher(BackboneTeacher backboneTeacher);
}
