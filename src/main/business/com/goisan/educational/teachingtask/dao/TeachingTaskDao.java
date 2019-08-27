package com.goisan.educational.teachingtask.dao;

import com.goisan.educational.teachingtask.bean.TeachingTask;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @function: 教学任务Dao层接口
 * @author: ZhangHao
 * @date: 2018/10/19
 */
@Repository
public interface TeachingTaskDao {

    int insertTeachingTask(TeachingTask teachingTask);

    int updateTeachingTask(TeachingTask teachingTask);

    int deleteTeachingTaskByIds(String ids);

    TeachingTask getTeachingTaskById(String id);

    List<TeachingTask> getTeachingTaskList(TeachingTask teachingTask);

    List<TeachingTask> getTeachingTaskList3(TeachingTask teachingTask);

    List<TeachingTask> getNewestPreparedBy();

    TeachingTask getTeachingTaskByClassIdAndCourseIdAndSemester(TeachingTask teachingTask);

    List<TeachingTask> getTeachingTaskListBydept(TeachingTask teachingTask);

    /**
     * 通过教师编号查找教师id
     * @param staffId
     * @return
     */
    String getPersonIdByStaffId(String staffId);
}