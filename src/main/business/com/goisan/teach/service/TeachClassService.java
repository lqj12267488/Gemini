package com.goisan.teach.service;

import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Tree;
import com.goisan.teach.bean.CourseTime;
import com.goisan.teach.bean.Task;
import com.goisan.teach.bean.TaskLog;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;


public interface TeachClassService {

    List<CourseTime> getCourseTime(CourseTime courseTime);
    CourseTime getCourseTimeById(String id);
    void saveCourseTime(CourseTime courseTime);
    void updateCourseTime(CourseTime courseTime);
    void deleteCourseTime(String id);
    List<Select2> getCourseByPerson (String teacherId);
    List<Tree> getClassByPerson (String teacherId, String courseId);

    Task getTaskByCourseIdAndCourseTime(Task task);
    List<Task> getTaskByClassIdAndCourseTime(Task task);
    void saveTask(Task task);
    List<Map> getTaskLog(String name, String className, String courseName, String data);

    List<Map<String, Object>> getTaskLogDetails(Map<String, Object> param);

    List<TaskLog> getTaskLogsByTaskIdAndUserId(String personId, String taskId);

    void saveTaskLog(TaskLog taskLog);
}
