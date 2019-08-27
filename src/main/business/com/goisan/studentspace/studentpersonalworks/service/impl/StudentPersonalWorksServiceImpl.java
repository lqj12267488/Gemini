package com.goisan.studentspace.studentpersonalworks.service.impl;


import com.goisan.studentspace.studentpersonalworks.bean.StudentPersonalWorks;
import com.goisan.studentspace.studentpersonalworks.dao.StudentPersonalWorksDao;
import com.goisan.studentspace.studentpersonalworks.service.StudentPersonalWorksService;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by mcq on 2017/8/21.
 */
@Service
public class StudentPersonalWorksServiceImpl implements StudentPersonalWorksService {
    @Resource
    private StudentPersonalWorksDao studentPersonalWorksDao;

    public List<StudentPersonalWorks> getPersonalWorksList(StudentPersonalWorks studentPersonalWorks) {
        return studentPersonalWorksDao.getPersonalWorksList(studentPersonalWorks);
    }

    public void saveStudentPersonalWorks(StudentPersonalWorks studentPersonalWorks) {
        studentPersonalWorksDao.saveStudentPersonalWorks(studentPersonalWorks);
    }

    public StudentPersonalWorks getStudentPersonalWorksById(String id) {
        return studentPersonalWorksDao.getStudentPersonalWorksById(id);
    }

    public void updateStudentPersonalWorks(StudentPersonalWorks studentPersonalWorks) {
        studentPersonalWorksDao.updateStudentPersonalWorks(studentPersonalWorks);
    }

    public void delStudentPersonalWorks(String id) {
        studentPersonalWorksDao.delStudentPersonalWorks(id);
    }
}
