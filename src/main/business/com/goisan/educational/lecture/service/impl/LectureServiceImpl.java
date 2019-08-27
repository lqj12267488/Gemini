package com.goisan.educational.lecture.service.impl;

import com.goisan.educational.lecture.bean.Lecture;
import com.goisan.educational.lecture.dao.LectureDao;
import com.goisan.educational.lecture.service.LectureService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class LectureServiceImpl implements LectureService {
@Resource
private LectureDao lectureDao;

    public List<Lecture> getLectureList(Lecture lecture) {
        return lectureDao.getLectureList(lecture);
    }

    public void saveLecture(BaseBean baseBean) {
        lectureDao.saveLecture(baseBean);
    }

    public BaseBean getLectureById(String id) {
        return lectureDao.getLectureById(id);
    }

    public void updateLecture(BaseBean baseBean) {
        lectureDao.updateLecture(baseBean);
    }

    public void delLecture(String id) {
        lectureDao.delLecture(id);
    }
}
