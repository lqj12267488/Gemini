package com.goisan.educational.lecture.dao;

import com.goisan.educational.lecture.bean.Lecture;
import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface LectureDao {

    List<Lecture> getLectureList(Lecture lecture);

    void saveLecture(BaseBean baseBean);

    BaseBean getLectureById(String id);

    void updateLecture(BaseBean baseBean);

    void delLecture(String id);

}
