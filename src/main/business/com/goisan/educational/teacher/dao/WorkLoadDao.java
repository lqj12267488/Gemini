package com.goisan.educational.teacher.dao;

/*import com.goisan.educational.course.bean.Course;
import com.goisan.educational.exam.bean.*;
import com.goisan.educational.major.bean.Major;
import com.goisan.educational.place.classroom.bean.Classroom;*/
import com.goisan.educational.teacher.bean.WorkLoadCheck;
/*import com.goisan.system.bean.*;
import com.sun.corba.se.spi.orbutil.threadpool.Work;
import org.apache.ibatis.annotations.Param;*/
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface WorkLoadDao {
    List<WorkLoadCheck> getWorkLoadCheckList(WorkLoadCheck workLoadCheck);
    WorkLoadCheck selectWorkLoadCheckById(String teacherId);
    void delWorkLoadCheckById(String teacherId);
    void updatetWorkLoad(WorkLoadCheck workLoadCheck);
    void insertWorkLoad(WorkLoadCheck workLoadCheck);
}
