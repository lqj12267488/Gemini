package com.goisan.educational.exam.service;

import com.goisan.educational.course.bean.Course;
import com.goisan.educational.exam.bean.*;
import com.goisan.educational.major.bean.Major;
import com.goisan.educational.place.classroom.bean.Classroom;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.system.bean.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ExamService {
    List<ScoreImport> checkImport (String examId);
    String getExamMethod (String courseId,String tremId);
    List<Select2> getRoomsByExamId (String examId);
    //考试信息
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
    List<Dept> chooseDeptList(String ids);

    List<ClassBean> chooseIdsList(String ids);

    //保存选中考试班级
    void insertExamCourseClass(ExamCourseClass examCourseClass);

    //选中的考试班级回显
    List<ExamCourseClass> getSelectedClassById(String examCourseId);

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

    //批量添加考生查看存在的班级
    List<ExamCourseClass> getExamClassByExamId(String examId);

    //考生信息列表
    List<ExamStudent> getExamStudentList(ExamStudent examStudent);

    //根据班级获取学生
    List<Student> getStudentListByClassId(String classId);

    //添加考生信息
    void insertExamStudent(ExamStudent examStudent);

    //再次批量添加考生删除原有的考生信息
    void deleteOriginalExamStudent(String examId);

    //考场信息列表
    List<ExamRoom> getExamRoomList(ExamRoom examRoom);

    //保存考场
    void insertExamRoom(ExamRoom examRoom);

    //修改考场
    void updateExamRoom(ExamRoom examRoom);

    //删除考场
    void delExamRoomById(String id);

    //查看考场根据Id
    ExamRoom selectExamRoomById(String id);

    //新增考场校验不能重复
    List<ExamRoom> getExamRoomById(String roomId, String examId);

    //新增考试科目校验不能重复
    List<ExamCourse> getExamCourseById(String examId, String courseId);

    //新增考试科目校验考试开始时间和考试结束时间不能重复
    List<ExamCourse> checkExamCourseStartTimeById(String courseId, String examId, String startTime);

    List<ExamCourse> checkExamCourseEndTimeById(String examId, String endTime);

    //查询监考教师数量
    String getExamTeacherCountByExamId(String examId);

    //查询考场的配置监考老师数量
    String getExamRoomTeacherSumByExamId(String examId);

    //根据考试ID查询监监考教师详情
    List<ExamTeacher> getExamTeacherById(String examId);

    //自动排考，手动排考，新增数据
    void insertExamRoomTeacher(ExamRoomTeacher examRoomTeacher);

    //查出已设置监考教师人员树形下拉选
    List<Tree> getEmpTreeForHandWork(String examId);

    //手动设置监考教师回显人员树
    List<ExamRoomTeacher> getSelectedEmpTreeByExamIdAndRoomId(@Param("examId") String examId, @Param("roomId") String roomId);

    //再次点击自动设置监考教师删除原有数据
    void deleteOriginalExamRoomTeacher(String examId);

    //校验是否能删除考场信息
    List<ExamRoomTeacher> getExamRoomTeacherByExamRoomId(String id);

    //手动设置监考教师获取原来的考场监考教师数量
    String getOriginalTeacherNum(@Param("examId") String examId, @Param("roomId") String roomId);

    //手动设置监考教师时获取选中人员的个数
    String getSelectedEmpSize(@Param("ids") String ids);

    //手动设置监考教师再次保存更新原有表
    void updateExamRoomTeacherByRoomIdForHandWork(ExamRoomTeacher examRoomTeacher);

    //删除考生信息
    void delExamStduentById(String id);

    //学生姓名自动提示框
    List<AutoComplete> autoCompleteStudent();

    //查询考场的配置考生数量
    String getExamRoomStudentSumByExamId(String examId);

    //查询参加考试的所有考生数量
    String getExamStudentCountByExamId(String examId);

    //自动排考列表
    List<ExamArray> getTeacherArrayList(ExamArray examArray);

    //根据ID查看自动排考列表中的数据
    ExamArray selectTeacherArrayById(String id);

    //自动排考
    void insertExamArray(ExamArray examArray);

    //修改自动排考列表中数据
    void updateTeacherArray(ExamArray examArray);

    //学生排考结果列表
    List<ExamArrayStudent> getStudentArrayList(ExamArrayStudent examArrayStudent);

    //删除自动排考列表中的数据
    void deleteTeacherArray(String id);

    //校验自动排考（学生排考）是否能重复点击
    List<Exam> checkExamListAutoPossibility(String examId);

    //修改排考状态
    void changeExamFlag(Exam exam);

    //校验学生排考是否能重复点击
    List<ExamArrayStudent> checkExamArrayStudentListAutoPossibility(@Param("examId") String examId);

    //查看条件成立该班级下存在的学生
    List<ExamStudent> selectExamStudentByClassId(String examId, String classId);

    //学生排考
    void insertExamArrayStudent(ExamArrayStudent examArrayStudent);

    //学生排考校验是否批量存在学生
    List<ExamStudent> getExamStudentById(@Param("examId") String examId);

    //查询考场的配置班级数量
    String getExamRoomClassNumByExamId(@Param("examId") String examId);

    //查询参加考试的所有班级数量
    String getExamStudentClassCountByExamId(@Param("examId") String examId);

    //学生排考时查询考场和考生表重复的系部、专业、班级
    List<ExamStudent> selectExamStudentInsideOfExamRoom(@Param("examId") String examId);

    //学生排考时查询考场和考生表不重复的系部、专业、班级
    List<ExamStudent> selectExamStudentOutsideOfExamRoom(@Param("examId") String examId);

    //学生排考时根据班级查询考场容量和考场
    List<ExamRoom> getExamRoomByClassId(@Param("examId") String examId, @Param("classId") String classId);

    //根据ID查看学生排考列表中的数据
    ExamArrayStudent selectStudentArrayById(String id);

    //修改学生排考列表中数据
    void updateStudentArray(ExamArrayStudent examArrayStudent);

    //批量添加考场获取班级属性
    List<ClassBean> getClassBeanPropertyForBatchAddExamRoom(@Param("examId") String examId);

    //再次点击批量添加考场删除原有的数据
    void deleteOriginalExamRoom(String examId);

    //删除考试安排
    void delExamArrayById(String id);

    //删除学生考试安排
    void delExamArrayStudentById(String id);

    String getClassRoomByClassId(@Param("classId") String classId);

    Classroom selectClassRoomById(String roomId);

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

    List<ExamCourse> getExamCourseByIds(String ids);

    void saveExamCourseTime(ExamCourse examCourse);

    //考场课程班级树
    List<Tree> getExamCourseExamClassTree(ExamCourseClass examCourseClass);

    //再次保存删除原有的课程班级
    void deleteOriginalExamCourseExamClass(ExamCourseClass examCourseClass);

    //选中的课程班级
    List<ClassBean> chooseCourseClassList(@Param("majorCode") String majorCode, @Param("ids") String ids);

    //课程班级关联表插入班级ID和选中的班级数据
    void insertExamCourseExamClass(ExamCourseClass examCourseClass);

    //考场所选中的班级回显
    List<ExamCourseClass> getSelectedClassByExamCourseClass(ExamCourseClass ExamCourseClass);

    //判断监考教师总数量
    Integer getTeacherNumberByExamRoom(String examId);

    //获取监考教师实际数量
    String getTeacherNumberByExamTeacherCourse();

    List<ExamArray> getExamCourseRoomTeacherList(ExamArray ExamArray);

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

    List getExamTime(ExamTime examTime);

    ExamTime getExamTimeById(String id);

    void delExamTimeById(String id);

    void updateExamTime(ExamTime examTime);

    void insertExamTime(ExamTime examTime);

    Integer autoAddStudent(String examId);

    void saveStatus(String id, String status);

    List<Tree> getEmpsTree(String id);

    void saveEmps(ExamTeacher examTeacher);

    void deleteExamTeacherByExamId(String id);

    List<ExamTime> getExamTimeByExamId(String examId);

    List<ExamCourseClass> getExamCourseClassByExamId(String examId);

    List<ExamStudent> getStudentsByExamId(String examId);

    List<ExamTeacher> getExamTeacherByEaxmId(String examId);

    List<ExamArray> getExamRoomByExamId(String examId);

    Integer updateExamArray(String examId);

    void deleteExamArrayStudentByExamId(String examId);

    List<ExamArrayStudent> getExamArrayStudentsByCurrent(String date, String startTime, String endTime, String examId);

    List<ExamStudent> getStudents(ExamStudent examStudent);

    void delExamStudentById(String id);

    List<ExamCourseClass> getExamCourseClassByClassIdAndCourseId(String classId, String courceId, String examId);

    void updateExamCourseStudent(ExamStudent examStudent);

    void insertExamCourseStudent(ExamStudent examStudent);

    ExamStudent getStudentById(String id, String examId, String courseId);

    List<ExamArray> getResult(String examId);

    List<String> getDate(String examId);

    int importClassData(String id);

    void deleteExamCourseClassByExamId(String id);

    List<ExamStudent> getExamStudentByStudentIdAndCourseIdAndTerm(String studentId, String courseId, String examId, String term, String examTypes);

    List<ExamCourseClass> examServicegetExamCourseClassFromExamStudent(String examId, String examTypes);

    List<ExamStudent> getExamStudentByCalssIdAndCourseId(String classId, String courseId, String examId);

    public void importExamCourseClassData(String examId);

    List<Select2> getTeachers(String id, String examId);

    void updateTeacher(String id, String teacherId, String teacherDept);

    List<Select2> getRooms(String id, String examId);

    void updateStudentRoom(String id, String roomId);

    List<Tree> getExamTree(String examId);

    int importStudent(String examId, String examIds, String examTypes);

    int importClassDataByStudent(String examId);

    //巡考教师
    List<ExamArray> getExaminationList(ExamArray examArray);

    List<String> getEdate(String examId);

    boolean checkScoreTime(String examId);

    ExamArray getExaminationById(String id);

    void updateExamination(ExamArray examArray);

    void insertExamination(ExamArray examArray);

    void delExamination(String id);

    ExamStudent getEaxmStudent(String courseId, String classId, String studentId, String term);

    void deleteExamStudentByExamId(String examId);
}