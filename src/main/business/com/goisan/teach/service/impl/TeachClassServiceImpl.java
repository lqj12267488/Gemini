package com.goisan.teach.service.impl;


import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Tree;
import com.goisan.system.dao.ParameterDao;
import com.goisan.system.tools.CommonUtil;
import com.goisan.teach.bean.CourseTime;
import com.goisan.teach.bean.Task;
import com.goisan.teach.bean.TaskClass;
import com.goisan.teach.bean.TaskLog;
import com.goisan.teach.dao.TeachClassDao;
import com.goisan.teach.service.TeachClassService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class TeachClassServiceImpl implements TeachClassService {


    @Autowired
    private TeachClassDao teachClassDao;

    @Autowired
    private ParameterDao parameterDao;

    @Override
    public List<CourseTime> getCourseTime(CourseTime courseTime) {
        return teachClassDao.getCourseTime(courseTime);
    }

    @Override
    public CourseTime getCourseTimeById(String id) {
        return teachClassDao.getCourseTimeById(id);
    }

    @Override
    public void saveCourseTime(CourseTime courseTime) {
        teachClassDao.saveCourseTime(courseTime);
    }

    @Override
    public void updateCourseTime(CourseTime courseTime) {
        teachClassDao.updateCourseTime(courseTime);
    }

    @Override
    public void deleteCourseTime(String id) {
        teachClassDao.deleteCourseTime(id);
    }

    @Override
    public List<Select2> getCourseByPerson(String teacherId) {
        String currentTerm = parameterDao.getParameterValue();
        return  teachClassDao.getCourseByPerson(currentTerm,teacherId);
    }

    @Override
    public List<Tree> getClassByPerson(String teacherId, String courseId) {
        String currentTerm = parameterDao.getParameterValue();
        return teachClassDao.getClassByPerson(currentTerm,teacherId,courseId);
    }

    @Override
    public Task getTaskByCourseIdAndCourseTime(Task task) {
        task.setCreator(CommonUtil.getPersonId());
        return teachClassDao.getTaskByCourseIdAndCourseTime(task, CommonUtil.now("yyyy-MM-dd"));
    }

    @Override
    public List<Task> getTaskByClassIdAndCourseTime(Task task) {
        return teachClassDao.getTaskByClassIdAndCourseTime(task,CommonUtil.now("yyyy-MM-dd"));
    }

    @Override
    @Transactional
    public void saveTask(Task task) {
        task.setCreator(CommonUtil.getPersonId());
        task.setCreateDept(CommonUtil.getDefaultDept());
        teachClassDao.saveTask(task);
//        if (task.getMajor().contains(",")) {
//            String[] classIds = task.getMajor().split(",");
//            for (String classId : classIds) {
//                String[] str = classId.split(":");
//                TaskClass taskClass = new TaskClass();
//                taskClass.setId(CommonUtil.getUUID());
//                taskClass.setClassId(str[0]);
//                taskClass.setTaskId(task.getId());
//                taskClass.setXz(str[2]);
//                teachClassDao.saveTaskClass(taskClass);
//            }
//        } else {
//            String[] str = task.getMajor().split(":");
            TaskClass taskClass = new TaskClass();
            taskClass.setId(CommonUtil.getUUID());
            taskClass.setClassId(task.getClassId());
            taskClass.setTaskId(task.getId());
            taskClass.setCreator(CommonUtil.getPersonId());
            taskClass.setChangeDept(CommonUtil.getDefaultDept());
//            taskClass.setXz(str[2]);
            teachClassDao.saveTaskClass(taskClass);
//        }
    }

    @Override
    public List<Map> getTaskLog(String name, String className, String courseName, String data) {
        return teachClassDao.getTaskLog(name, className, courseName, data);
    }

    @Override
    public List<Map<String, Object>> getTaskLogDetails(Map<String, Object> param) {
        return teachClassDao.getTaskLogDetails(param);
    }

    @Override
    public List<TaskLog> getTaskLogsByTaskIdAndUserId(String personId, String taskId) {
        return teachClassDao.getTaskLogsByTaskIdAndUserId(personId, taskId);
    }

    @Override
    public void saveTaskLog(TaskLog taskLog) {
        teachClassDao.saveTaskLog(taskLog);
    }
}
