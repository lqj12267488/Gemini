package com.goisan.task.dao;

import com.goisan.task.bean.SysTask;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by mcq on 2017/8/31.
 */
public interface TaskDao  {

    void saveSysTask(SysTask task);

    List <SysTask> findTaskList(String personId);

    SysTask selectSysTaskById(@Param("personId") String businessId, @Param("time") String time);

    SysTask selectSysTaskByTaskId(String taskId);

    String getTaskTimeById(String id);

    void updateTaskFlag(SysTask task);

    void updateTaskFlagByConditions(SysTask task);


}
