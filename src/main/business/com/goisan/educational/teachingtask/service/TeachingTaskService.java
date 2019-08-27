package com.goisan.educational.teachingtask.service;

import com.goisan.educational.exam.bean.ExamCourseClass;
import com.goisan.educational.teachingtask.bean.TeachingTask;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.Emp;
import com.goisan.system.bean.Select2;
import com.goisan.system.tools.Message;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * @function: 教学任务Service层接口
 * @author: ZhangHao
 * @date: 2018/10/19
 */
public interface TeachingTaskService {


    Message saveOrUpdateTeachingTask(TeachingTask teachingTask);

    Message deleteTeachingTaskByIds(String ids);

    TeachingTask getTeachingTaskById(String id);

    List<TeachingTask> getTeachingTaskList(TeachingTask teachingTask);

    boolean readOutTemplate(HttpServletRequest request, HttpServletResponse response);

    Message loadingExcel(CommonsMultipartFile file);

    TeachingTask getEmpByPreparedBy();

    Message readOutTeachingTaskData(HttpServletRequest request, HttpServletResponse response);

    TeachingTask getTeachingTaskByClassIdAndCourseIdAndSemester(String classInfo, String courseId, String semester);

    List<Select2> checkCourseForTeacher(String teacherId, String semester, String examId);

    List<Select2> checkSemesterForTeacher(String teacherId);

    List<TeachingTask> getTeachingTaskListBydept(TeachingTask teachingTask);

    /**
     * 通过教师编号查找教师id
     * @param staffId
     * @return
     */
    String getPersonIdByStaffId(String staffId);
}
