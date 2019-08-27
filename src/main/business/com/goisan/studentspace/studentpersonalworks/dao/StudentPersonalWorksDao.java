package com.goisan.studentspace.studentpersonalworks.dao;


import com.goisan.studentspace.studentpersonalworks.bean.StudentPersonalWorks;
import org.springframework.stereotype.Repository;
import java.util.List;

/**
 * Created by mcq on 2017/8/21.
 */
@Repository
public interface StudentPersonalWorksDao {

    List<StudentPersonalWorks> getPersonalWorksList(StudentPersonalWorks studentPersonalWorks);

    void saveStudentPersonalWorks(StudentPersonalWorks studentPersonalWorks);

    StudentPersonalWorks getStudentPersonalWorksById(String id);

    void updateStudentPersonalWorks(StudentPersonalWorks studentPersonalWorks);

    void delStudentPersonalWorks(String id);
}
