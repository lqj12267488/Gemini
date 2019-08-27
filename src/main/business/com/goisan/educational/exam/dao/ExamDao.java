package com.goisan.educational.exam.dao;

import com.goisan.educational.course.bean.Course;
import com.goisan.educational.exam.bean.*;
import com.goisan.educational.major.bean.Major;
import com.goisan.educational.place.classroom.bean.Classroom;
import com.goisan.system.bean.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface ExamDao {
    //考试信息
    String getExamMethod (@Param("courseId") String courseId,@Param("tremId") String tremId);
    List<Exam> getExamList(Exam exam);

    List<Exam> getExamListByTermType(Exam exam);

    List<Exam> getExamList2(Exam exam);

    //个人
    List<Exam> getPersonalExamList(Exam exam);

    void insertExam(Exam exam);

    Exam selectExamById(String id);

    void updateExam(Exam exam);

    void delExamById(String id);

    //考试科目
    List<ExamCourse> getExamCourseList(ExamCourse examCourse);

    void insertExamCourse(ExamCourse examCourse);

    ExamCourse selectExamCourseById(String id);

    void updateExamCourse(ExamCourse examCourse);

    void delExamCourseById(String id);

    //校验是否能删除考试信息
    List<ExamCourse> getExamCourseByExamId(String id);

    //校验是否能删除考试科目
    List<ExamCourseClass> getExamCourseClassByExamCourseId(String id);

    //班级树形下拉选
    List<Tree> getALLClassTree();

    List<Tree> getClassTreeByDepartmentId(String deptid);

    //选出部门、专业、班级ID
    List<Dept> chooseDeptList(@Param("ids") String ids);

    List<ClassBean> chooseIdsList(@Param("ids") String ids);

    //保存选中考试班级
    void insertExamCourseClass(ExamCourseClass examCourseClass);

    //选中的考试班级回显
    List<ExamCourseClass> getSelectedClassById(@Param("examCourseId") String examCourseId);

    //再次保存删除原有的考试班级
    void deleteOriginalExamCourseClass(String examCourseId);

    //人员树形下拉选
    List<Tree> getAllEmpTree();

    //选中的人员
    List<Emp> chooseEmpList(@Param("dept_id") String dept_id, @Param("ids") String ids);

    //保存选中监考教师
    void insertExamTeacher(ExamTeacher examTeacher);

    //选中的监考教师回显
    List<ExamTeacher> getSelectedEmpByExamId(@Param("examId") String examId);

    //再次保存删除原有的监考教师数据
    void deleteOriginalExamTeacher(String examId);

    //考场信息列表
    List<ExamRoom> getExamRoomList(ExamRoom examRoom);

    //新增考场
    void insertExamRoom(ExamRoom examRoom);

    //修改考场
    void updateExamRoom(ExamRoom examRoom);

    //删除考场
    void delExamRoomById(String id);

    //查看考场根据Id
    ExamRoom selectExamRoomById(String id);

    //新增考场校验不能重复
    List<ExamRoom> getExamRoomById(@Param("roomId") String roomId, @Param("examId") String examId);

    //新增考试科目校验不能重复
    List<ExamCourse> getExamCourseById(@Param("examId") String examId, @Param("courseId") String courseId);

    //新增考试科目校验考试开始时间不能重复
    List<ExamCourse> checkExamCourseStartTimeById(@Param("courseId") String courseId, @Param("examId") String examId, @Param("startTime") String startTime);

    //新增考试科目校验考试结束时间不能重复
    List<ExamCourse> checkExamCourseEndTimeById(@Param("examId") String examId, @Param("endTime") String endTime);

    //查询监考教师数量
    String getExamTeacherCountByExamId(String examId);

    //查询考场的配置监考老师数量
    String getExamRoomTeacherSumByExamId(String examId);

    //根据考试ID查询监监考教师详情
    List<ExamTeacher> getExamTeacherById(@Param("examId") String examId);

    //自动排考，手动排考，新增数据
    void insertExamRoomTeacher(ExamRoomTeacher examRoomTeacher);

    //查出已设置监考教师人员树形下拉选
    List<Tree> getEmpTreeForHandWork(@Param("examId") String examId);

    //手动设置监考教师回显人员树
    List<ExamRoomTeacher> getSelectedEmpTreeByExamIdAndRoomId(@Param("examId") String examId, @Param("roomId") String roomId);

    //再次点击自动设置监考教师删除原有数据
    void deleteOriginalExamRoomTeacher(String examId);

    //校验是否能删除考场信息
    List<ExamRoomTeacher> getExamRoomTeacherByExamRoomId(@Param("id") String id);

    //手动设置监考教师获取原来的考场监考教师数量
    String getOriginalTeacherNum(@Param("examId") String examId, @Param("roomId") String roomId);

    //手动设置监考教师时获取选中人员的个数
    String getSelectedEmpSize(@Param("ids") String ids);

    //手动设置监考教师再次保存更新原有表
    void updateExamRoomTeacherByRoomIdForHandWork(ExamRoomTeacher examRoomTeacher);

    //批量添加考生时查看存在的班级
    List<ExamCourseClass> getExamCourseClassByExamId(String examId);

    //考生信息列表
    List<ExamStudent> getExamStudentList(ExamStudent examStudent);

    //根据班级获取学生
    List<Student> getStudentListByClassId(String classId);

    //批量添加考生信息
    void insertExamStudent(ExamStudent examStudent);

    //再次批量添加考生删除原有的考生信息
    void deleteOriginalExamStudent(String examId);

    //删除考生信息
    void delExamStduentById(String id);

    //学生姓名自动提示框
    List<AutoComplete> autoCompleteStudent();

    //查询考场的配置考生数量
    String getExamRoomStudentSumByExamId(@Param("examId") String examId);

    //查询参加考试的所有考生数量
    String getExamStudentCountByExamId(@Param("examId") String examId);

    //自动排考结果列表
    List<ExamArray> getTeacherArrayList(ExamArray examArray);

    //自动排考
    void insertExamArray(ExamArray examArray);

    //根据ID查看自动排考列表中的数据
    ExamArray selectTeacherArrayById(String id);

    //根据ID查看学生排考列表中的数据
    ExamArrayStudent selectStudentArrayById(String id);

    //删除自动排考列表中的数据
    void deleteTeacherArray(String id);

    //修改自动排考列表中数据
    void updateTeacherArray(ExamArray examArray);

    //修改学生排考列表中数据
    void updateStudentArray(ExamArrayStudent examArrayStudent);

    //学生排考结果列表
    List<ExamArrayStudent> getStudentArrayList(ExamArrayStudent examArrayStudent);

    //校验自动排考是否能重复点击
    List<Exam> checkExamListAutoPossibility(@Param("examId") String examId);

    //修改排考状态
    void changeExamFlag(Exam exam);

    //校验学生排考是否能重复点击
    List<ExamArrayStudent> checkExamArrayStudentListAutoPossibility(@Param("examId") String examId);

    //学生排考时查询考场和考生表重复的系部、专业、班级
    List<ExamStudent> selectExamStudentInsideOfExamRoom(@Param("examId") String examId);

    //学生排考时查询考场和考生表不重复的系部、专业、班级
    List<ExamStudent> selectExamStudentOutsideOfExamRoom(@Param("examId") String examId);

    //查看条件成立该班级下存在的学生
    List<ExamStudent> selectExamStudentByClassId(@Param("examId") String examIdentsId, @Param("classId") String classId);

    //学生排考
    void insertExamArrayStudent(ExamArrayStudent examArrayStudent);

    //学生排考校验是否批量存在学生
    List<ExamStudent> getExamStudentById(@Param("examId") String examId);

    //查询考场的配置班级数量
    String getExamRoomClassNumByExamId(@Param("examId") String examId);

    //查询参加考试的所有班级数量
    String getExamStudentClassCountByExamId(@Param("examId") String examId);

    //学生排考时根据班级查询考场容量和考场
    List<ExamRoom> getExamRoomByClassId(@Param("examId") String examId, @Param("classId") String classId);

    //批量添加考场获取班级属性
    List<ClassBean> getClassBeanPropertyForBatchAddExamRoom(@Param("examId") String examId);

    //再次点击批量添加考场删除原有的数据
    void deleteOriginalExamRoom(String examId);

    //删除考试安排
    void delExamArrayById(String id);

    //删除学生考试安排
    void delExamArrayStudentById(String id);

    String getClassRoomByClassId(String classId);

    Classroom selectClassRoomById(@Param("roomId") String roomId);

    //查询所有考场的班级
    String getAllExamRoomClassNumByExamId(@Param("examId") String examId);

    //查询所有参加考试的班级数量
    String getAllExamCourseClassNumByExamId(@Param("examId") String examId);

    List<ExamCourseClass> findExamCourseListByExamId(@Param("examId") String examId);

    List<ExamCourseClass> findExamCourseListByClassId(@Param("classId") String classId);

    ExamRoomClass selectExamRoomTeacherByExamIdAndClassId(@Param("examId") String examId, @Param("classId") String classId);

    //获取教室容纳人数
    Classroom getPeopleNumber(String roomId);

    //考场设置班级树
    List<Tree> getExamRoomClassTree();

    //再次保存删除原有的监考教师数据
    void deleteOriginalExamClass(ExamClass examClass);

    //选中的班级
    List<ClassBean> chooseClassList(@Param("majorCode") String majorCode, @Param("ids") String ids);

    //考试班级表插入考场ID和选中的班级数据
    void insertExamClass(ExamClass examClass);

    //考场所选中的班级回显
    List<ExamClass> getSelectedClassByExamRoomId(ExamClass examClass);

    //判断考场所选中的班级的学生总人数是否大于容纳总人数
    Integer getStudentNumberByClassId(@Param("ids") String ids);

    //获取场地容纳总人数
    Integer getPeopleNumberByExamId(String examRoomId);

    List<Major> chooseMajorList(@Param(value = "dept_id") String dept_id, @Param(value = "ids") String ids);

    //根据考场查询班级
    List<String> getClassIdByRoom(ExamClass examClass);

    //根据考场id获取场地类型
    String getRoomTypeByExamRoomId(String examRoomId);

    List<Tree> getExamCourseClassTree(ExamCourse examCourse);

    //每个班级插入对应的考试科目回显
    List<ExamCourse> getSelectedCourseByExamRoomId(ExamCourse examCourse);

    //判断考场内是否有班级
    List<ExamClass> getExamClassByExamRoom(ExamRoom examRoom);

    //获取课程id
    List<Course> chooseCourseList(@Param(value = "majorCode") String majorCode, @Param(value = "ids") String ids);

    //删除课程
    void deleteOriginalExamCourse(ExamCourse examCourse);

    //获得课程根据ids
    List<ExamCourse> getExamCourseByIds(@Param("ids") String ids);

    //设置科目考试时间
    void saveExamCourseTime(ExamCourse examCourse);

    //考场课程班级树
    List<Tree> getExamCourseExamClassTree(ExamCourseClass examCourseClass);

    //再次保存删除原有的课程班级
    void deleteOriginalExamCourseExamClass(ExamCourseClass examCourseClass);

    //选中的课程班级
    List<ClassBean> chooseCourseClassList(@Param("majorCode") String majorCode, @Param("ids") String ids);

    //课程班级关联表插入班级ID和选中的班级数据
    void insertExamCourseExamClass(ExamCourseClass examCourseClass);

    //课程对应选中的班级回显
    List<ExamCourseClass> getSelectedClassByExamCourseClass(ExamCourseClass ExamCourseClass);

    //判断监考教师总数量
    Integer getTeacherNumberByExamRoom(String examId);

    //获取监考教师实际数量
    String getTeacherNumberByExamTeacherCourse();

    List<ExamArray> getExamCourseRoomTeacherList(ExamArray examArray);

    //校验考试场地下是否有课程
    List<ExamCourse> getExamCourseByExamRoom(ExamRoom examRoom);

    //查询考场对应的监考教师
    String getTeacherPersonIdByExamRoomTeacher(ExamRoomTeacher examRoomTeacher);

    String getExamCourseNum(String examId);

    String getExamCourseTime(String examId);

    String getExamClassByExamCourse(String examId);

    ExamCourseClass getExamCourseClassById(String id);

    void delExamCourseClassById(String id);

    void updateExamCourseClass(ExamCourseClass examCourseClass);

    List<ExamCourseClass> getExamCourseClass(ExamCourseClass examCourseClass);

    List<ExamTime> getExamTime(ExamTime examTime);

    ExamTime getExamTimeById(String id);

    void delExamTimeById(String id);

    void updateExamTime(ExamTime examTime);

    void insertExamTime(ExamTime examTime);

    Integer autoAddStudent(@Param("examId") String examId);

    void saveStatus(@Param("id") String id, @Param("status") String status);

    List<Tree> getEmpsTree(String id);

    void saveEmps(ExamTeacher examTeacher);

    void deleteExamTeacherByExamId(String id);

    List<ExamTime> getExamTimeByExamId(String examId);

    List<ExamStudent> getStudentsByExamId(String examId);

    List<ExamTeacher> getExamTeacherByEaxmId(String examId);

    List<ExamArray> getExamRoomByExamId(String examId);

    Integer updateExamArray(String examId);

    void deleteExamArrayStudentByExamId(String examId);

    List<ExamArrayStudent> getExamArrayStudentsByCurrent(@Param("date") String date, @Param("startTime") String startTime, @Param("endTime") String endTime, @Param("examId") String examId);

    List<ExamCourseClass> getExamCourseClassByExamIdAndClassId(ExamCourseClass examCourseClass);

    List<ExamCourseClass> getExamClassByExamId(String examId);

    List<ExamStudent> getStudents(ExamStudent examStudent);

    void delExamStudentById(String id);

    List<ExamCourseClass> getExamCourseClassByClassIdAndCourseId(@Param("classId") String classId, @Param("courseId") String courseId, @Param("examId") String examId);

    void insertExamCourseStudent(ExamStudent examStudent);

    void updateExamCourseStudent(ExamStudent examStudent);

    ExamStudent getStudentById(@Param("id") String id, @Param("examId") String examId, @Param("courseId") String courseId);

    List<ExamArray> getResult(String examId);

    List<String> getDate(String examId);

    void changeOpenFlag(String id);

    int importClassData(String id);

    void deleteExamCourseClassByExamId(String id);

    List<ExamStudent> getExamStudentByStudentIdAndCourseIdAndTerm(@Param("studentId") String studentId, @Param("courseId") String courseId, @Param("examId") String examId, @Param("term") String term, @Param("examTypes") String examTypes);

    List<ExamCourseClass> examServicegetExamCourseClassFromExamStudent(@Param("examId") String examId, @Param("examTypes") String examTypes);

    void importExamCourseClassData(String examId);

    List<ExamStudent> getExamStudentByCalssIdAndCourseId(@Param("classId") String classId, @Param("courseId") String courseId, @Param("examId") String examId);

    List<Select2> getTeachers(@Param("id") String id, @Param("examId") String examId);

    void updateTeacher(@Param("id") String id, @Param("teacherId") String teacherId, @Param("teacherDept") String teacherDept);

    List<Select2> getRooms(@Param("id") String id, @Param("examId") String examId);

    void updateStudentRoom(@Param("id") String id, @Param("roomId") String roomId);

    List<Tree> getExamTree(String examId);

    /**
     *@Param examTypesValue 用于 毕业前补考，导入期末考试违纪学生。
     */
    int importStudent(@Param("examId") String examId, @Param("examIds") String examIds, @Param("examTypes") String examTypes ,@Param("examTypesValue") String examTypesValue);

    int importClassDataByStudent(String examId);

    List<ExamArray> getExaminationList(ExamArray examArray);

    List<String> getEdate(String examId);

    ExamArray getExaminationById(String id);

    void updateExamination(ExamArray examArray);

    void insertExamination(ExamArray examArray);

    void delExamination(String id);

    List<Map<String, String>> getScoreTime(@Param("examId") String examId, @Param("now") String now);

    List<ExamCourseClass> getExamCourseClassByCourseId(@Param("courseId") String courseId, @Param("examId") String examId, @Param("classId") String classId);

    ExamStudent getEaxmStudent(@Param("courseId") String courseId, @Param("classId") String classId, @Param("studentId") String studentId, @Param("term") String term);

    void deleteExamStudentByExamId(String examId);

    List<Select2> getRoomsByExamId (String examId);
}
