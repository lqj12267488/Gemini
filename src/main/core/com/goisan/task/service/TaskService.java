package com.goisan.task.service;

import com.goisan.task.bean.SysTask;

import java.util.List;

/**
 * Created by mcq on 2017/8/31.
 */
public interface TaskService {
    void saveSysTask(SysTask task);

    List<SysTask> findTaskList(String personId);

    SysTask selectSysTaskById(String personId,String time);

    SysTask selectSysTaskByTaskId(String taskId);

    String getTaskTimeById(String id);

    void updateTaskFlag(SysTask task);

    void updateTaskFlagByConditions(SysTask task);

}
