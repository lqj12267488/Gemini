package com.goisan.teach.dao;


import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Tree;
import com.goisan.teach.bean.CourseTime;
import com.goisan.teach.bean.Task;
import com.goisan.teach.bean.TaskClass;
import com.goisan.teach.bean.TaskLog;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface TeachClassDao {

    List<CourseTime> getCourseTime(CourseTime courseTime);
    CourseTime getCourseTimeById(String id);
    void saveCourseTime(CourseTime courseTime);
    void updateCourseTime(CourseTime courseTime);
    void deleteCourseTime(String id);
    List<Select2> getCourseByPerson (@Param("semester") String semester, @Param("teacherId") String teacherId);
    List<Tree> getClassByPerson (@Param("semester") String semester, @Param("teacherId") String teacherId, @Param("courseId") String courseId);

    Task getTaskByCourseIdAndCourseTime(@Param("task") Task task, @Param("now") String now);
    List<Task> getTaskByClassIdAndCourseTime(@Param("task") Task task, @Param("now") String now);
    void saveTask(Task task);
    void saveTaskClass(TaskClass taskClass);
    List<Map> getTaskLog(@Param("name") String name, @Param("className") String className, @Param("courseName") String courseName, @Param("data") String data);

    List<Map<String, Object>> getTaskLogDetails(Map<String, Object> param);

    List<TaskLog> getTaskLogsByTaskIdAndUserId(@Param("personId") String personId, @Param("taskId") String taskId);

    void saveTaskLog(TaskLog taskLog);
}
