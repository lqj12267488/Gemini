package com.goisan.educational.arrayclass.dao;

import com.goisan.educational.arrayclass.bean.*;
import com.goisan.educational.courseplan.bean.CoursePlan;
import com.goisan.educational.major.bean.Major;
import com.goisan.system.bean.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * Created by Zym on 2017/8/7 0013.
 */
@Service
public interface ArrayClassDao {
    //排课计划维护
    List<ArrayClass> getArrayclassTeacherId(String arrayClassId);

    String getPlanIdByArrayClassId(String arrayClassId);

    List<ArrayClassCoursePlan> getArrayClassListBySchoolYearTermCoursePlan(ArrayClassCoursePlan arrayClassCoursePlan);

    List<ArrayClass> getArrayClassList(ArrayClass arrayClass);

    List<ArrayClassTime> getArrayClassTimeList(ArrayClassTime arrayClassTime);

    List<ArrayClassTime> checkArrayClassTimeList(ArrayClassTime arrayClassTime);

    void insertArrayClass(ArrayClass arrayClass);

    void insertArrayClassTime(ArrayClassTime arrayClassTime);

    ArrayClass getArrayClassById(String id);

    ArrayClassTime getArrayClassTimeById(String id);

    List<ArrayClassCoursePlan> getArrayClassPlan(String id);

    void updateArrayClass(ArrayClass arrayClass);

    void editArrayClassFlagById(String id, String flag);

    void updateArrayClassTime(ArrayClassTime arrayClassTime);

    void deleteArrayClassById(String id);

    void deleteArrayClassTimeById(String id);

    List<CoursePlan> checkCoursePlanForArrayClass();

    List<ArrayClass> getArrayClassId();

    List<ArrayclassArray> getArrayClassArray(String arrayclassId);

    void insertCoursePlanForArrayClassCoursePublic(ArrayClassCourse arrayClassCourse);

    void insertCoursePlanForArrayClassCourse(ArrayClassCourse arrayClassCourse);

    void insertCoursePlanForArrayClassResultClass(ArrayclassResultClass arrayclassResultClass);

    void insertCoursePlanForArrayClassClass(@Param(value = "arrayClassClass") ArrayClassClass arrayClassClass, @Param(value = "planId") String planId);

    void insertCoursePlanForArrayClassRoom(@Param(value = "arrayClassRoom") ArrayClassRoom arrayClassRoom, @Param(value = "planId") String planId);

    void insertCoursePlanForArrayClassTeacherCoursePublic(@Param(value = "arrayClassTeacherCourse") ArrayClassTeacherCourse arrayClassTeacherCourse, @Param(value = "planId") String planId);

    void insertCoursePlanForArrayClassTeacherCourse(@Param(value = "arrayClassTeacherCourse") ArrayClassTeacherCourse arrayClassTeacherCourse, @Param(value = "planId") String planId);

    void insertCoursePlanForArrayClassTeacher(@Param(value = "arrayClassTeacher") ArrayClassTeacher arrayClassTeacher, @Param(value = "planId") String planId);

    void insertCoursePlanForArrayClassArray(@Param(value = "arrayclassArray") ArrayclassArray arrayclassArray, @Param(value = "planId") String planId);

    void deleteCoursePlanForArrayClassCourse(String arrayClassId);

    void deleteCoursePlanForArrayClassClass(String arrayClassId);

    void deleteCoursePlanForArrayClassRoom(String arrayClassId);

    void deleteCoursePlanForArrayClassTeacherCourse(String arrayClassId);

    void deleteCoursePlanForArrayClassTeacher(String arrayClassId);

    void deleteCoursePlanForArrayClassArray(String arrayClassId);

    List<ArrayClassCoursePlan> getArrayClassCoursePlanList(ArrayClassCoursePlan arrayClassCoursePlan);

    ArrayClassCoursePlan getArrayClassCoursePlanById(String id);

    void deleteArrayClassCoursePlan(String id);

    void insertArrayClassCoursePlan(ArrayClassCoursePlan arrayClassCoursePlan);

    void inserCoursePlan(ArrayClassCoursePlan arrayClassCoursePlan);

    void updateArrayClassCoursePlan(ArrayClassCoursePlan arrayClassCoursePlan);

    String getCourseTypeById(String id);

    /////////////////////

    List<ArrayClassCourse> getArrayClassCourseList(ArrayClassCourse arrayClassCourse);

    void insertArrayClassCourse(ArrayClassCourse arrayClassCourse);

    List<ArrayClassCourse> getArrayClassCourseByCourse(ArrayClassCourse arrayClassCourse);

    List<ArrayClassCourse> getArrayClassCourseBy(ArrayClassCourse arrayClassCourse);

    ArrayClassCourse getArrayClassCourseById(String id);

    void updateArrayClassCourse(ArrayClassCourse arrayClassCourse);

    void deleteArrayClassCourseById(String id);

    List<ArrayClassCourseWeek> getArrayClassCourseWeekList(ArrayClassCourseWeek arrayClassCourseWeek);

    void insertArrayClassCourseWeek(ArrayClassCourseWeek arrayClassCourseWeek);

    ArrayClassCourseWeek getArrayClassCourseWeekById(String id);

    void updateArrayClassCourseWeek(ArrayClassCourseWeek arrayClassCourseWeek);

    void deleteArrayClassCourseWeekById(String id);

    ArrayClassTeacher getArrayClassTeacherByid(String id);

    List<Tree> getALLClassTree();

    List<Tree> getClassTreeByDepartmentId(String id);

    List<ArrayClassCourseWeekClass> getSelectedClassById(String id);

    void deleteOriginalCourseClass(String id);

    List<Dept> chooseDeptList(@Param(value = "id") String id);

    List<Major> chooseMajorList(@Param(value = "dept_id") String dept_id, @Param(value = "id") String id);

    List<ClassBean> chooseClassList(@Param(value = "majorCode") String majorCode, @Param(value = "id") String id);

    void insertClass(ArrayClassCourseWeekClass arrayClassCourseWeekClass);

    List<Select2> getClassTree(String roomType);

    //排课班级设置
    List<BaseBean> getArrayClassClassList(BaseBean baseBean);

    void saveArrayClassClass(BaseBean baseBean);

    BaseBean getArrayClassClassById(String id);

    void updateArrayClassClass(BaseBean baseBean);

    void delArrayClassClass(String id);

    ArrayClassClass selectArrayClassClassById(String id);
    //排课禁排学时
    List<ArrayClassCondition> getArrayClassConditionList(ArrayClassCondition arrayClassCondition);

    void insertArrayClassCondition(ArrayClassCondition arrayClassCondition);

    void updateArrayClassCondition(ArrayClassCondition arrayClassCondition);

    void deleteArrayClassCondition(String id);

    List<ArrayClassCondition> getArrayClassConditionByCondition(ArrayClassCondition arrayClassCondition);

    ArrayClassCondition getArrayClassConditionById(String id);

    String selectConditionName(ArrayClassCondition arrayClassCondition);

    String selectClassId(String elementsId);

    String selectCourseId(String elementsId);

    String selectTeacherPerson(String elementsId);

    String selectRoomName(String elementsId);
    //<!--Begin wq-->
    //排课场地设置 create: wq 2017/08/11
    List<ArrayClassRoom> getArrayClassRoomList(ArrayClassRoom arrayClassRoom);

    void insertArrayClassRoom(ArrayClassRoom arrayClassRoom);

    ArrayClassRoom getArrayClassRoomById(String id);

    void updateArrayClassRoom(ArrayClassRoom arrayClassRoom);

    void deleteArrayClassRoomById(String id);

    List<ArrayClassRoom> checkRoom(ArrayClassRoom arrayClassRoom);

    void deleteArrayClassRoomBatch(String arrayClassId);

    void addArrayClassRoomBatch(@Param("createTime") Date createTime, @Param("arrayClassId") String arrayClassId, @Param("creator") String creator, @Param("createDept") String createDept);
    //排课教师设置 modify: wq 2017/08/23
    List<ArrayClassTeacher> getArrayClassTeacher(ArrayClassTeacher arrayClassTeacher);

    void saveArrayClassTeacher(ArrayClassTeacher arrayClassTeacher);

    void delArrayClassTeacher(String arrayclassTeacherId);

    ArrayClassTeacher getArrayClassTeacherById(String arrayclassTeacherId);

    void updateArrayClassTeacher(ArrayClassTeacher arrayClassTeacher);

    List<ArrayClassTeacher> checkTeacher(ArrayClassTeacher arrayClassTeacher);
    //排课教师任课课程设置 create: wq 2017/08/23
    List<ArrayClassTeacherCourse> getArrayClassTeacherCourseList(ArrayClassTeacherCourse arrayClassTeacherCourse);

    void insertArrayClassTeacherCourse(ArrayClassTeacherCourse arrayClassTeacherCourse);

    ArrayClassTeacherCourse getArrayClassTeacherCourseById(String id);

    void updateArrayClassTeacherCourse(ArrayClassTeacherCourse arrayClassTeacherCourse);

    void deleteArrayClassTeacherCourseById(String id);

    ArrayClassCourse getCourseById(ArrayClassCourse arrayClassCourse);
// <!--end wq-->

    /*
    * yangshuang
    * */
    List<BaseBean> getSchedule(String userId);

    List<BaseBean> getStudentSchedule(String userId);

}
