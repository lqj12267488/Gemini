package com.goisan.task.service.impl;

import com.goisan.task.bean.SysTask;
import com.goisan.task.dao.TaskDao;
import com.goisan.task.service.TaskService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by mcq on 2017/8/31.
 */
@Service
public class TaskServiceImpl implements TaskService {
    @Resource
    private TaskDao taskDao;

    public void saveSysTask(SysTask task) {
        taskDao.saveSysTask(task);
    }

    public List<SysTask> findTaskList(String personId) {
        return taskDao.findTaskList(personId);
    }

    public SysTask selectSysTaskById(String personId,String time) {
        return taskDao.selectSysTaskById(personId,time);
    }

    public SysTask selectSysTaskByTaskId(String taskId) {
        return taskDao.selectSysTaskByTaskId(taskId);
    }

    public String getTaskTimeById(String id) {
        return taskDao.getTaskTimeById(id);
    }

    public void updateTaskFlag(SysTask task) {
        taskDao.updateTaskFlag(task);
    }

    public void updateTaskFlagByConditions(SysTask task) {
        taskDao.updateTaskFlagByConditions(task);
    }


}
