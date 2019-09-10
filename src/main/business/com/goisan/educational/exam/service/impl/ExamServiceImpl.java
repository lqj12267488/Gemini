package com.goisan.educational.exam.service.impl;

import com.goisan.educational.course.bean.Course;
import com.goisan.educational.exam.bean.*;
import com.goisan.educational.exam.dao.ExamDao;
import com.goisan.educational.exam.service.ExamService;
import com.goisan.educational.major.bean.Major;
import com.goisan.educational.place.classroom.bean.Classroom;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.system.bean.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class ExamServiceImpl implements ExamService {
    @Resource
    private ExamDao examDao;

    @Override
    public List<ScoreImport> checkImport(String examId) {
        return examDao.checkImport(examId);
    }

    @Override
    public String getExamMethod(String courseId,String termId) {
        return examDao.getExamMethod(courseId,termId);
    }

    @Override
    public List<Select2> getRoomsByExamId(String examId) {
        return examDao.getRoomsByExamId(examId);
    }

    public List<Exam> getExamList(Exam exam) {
        return examDao.getExamList(exam);
    }

    public List<Exam> getExamListByTermType(Exam exam){ return examDao.getExamListByTermType(exam); }

    public List<Exam> getExamList2(Exam exam) {
        return examDao.getExamList2(exam);
    }

    @Override
    public List<Exam> getPersonalExamList(Exam exam) {
        return examDao.getPersonalExamList(exam);
    }

    public void insertExam(Exam exam) {
        examDao.insertExam(exam);
    }

    public Exam selectExamById(String id) {
        return examDao.selectExamById(id);
    }

    public void updateExam(Exam exam) {
        examDao.updateExam(exam);
    }

    @Transactional
    public void delExamById(String id) {
        examDao.delExamById(id);
        examDao.delExamTime(id);
        examDao.delExamTeacher(id);
        examDao.delExamCourseClass(id);
        examDao.delExamStudent(id);
        examDao.delExamRoomTeacher(id);
        examDao.delExamExamination(id);
    }

    public List<ExamCourse> getExamCourseList(ExamCourse examCourse) {
        return examDao.getExamCourseList(examCourse);
    }

    public void insertExamCourse(ExamCourse examCourse) {
        examDao.insertExamCourse(examCourse);
    }

    public ExamCourse selectExamCourseById(String id) {
        return examDao.selectExamCourseById(id);
    }

    public void updateExamCourse(ExamCourse examCourse) {
        examDao.updateExamCourse(examCourse);
    }

    public void delExamCourseById(String id) {
        examDao.delExamCourseById(id);
    }

    public List<ExamCourse> getExamCourseByExamId(String id) {
        return examDao.getExamCourseByExamId(id);
    }

    public List<ExamCourseClass> getExamCourseClassByExamCourseId(String id) {
        return examDao.getExamCourseClassByExamCourseId(id);
    }

    public List<Tree> getALLClassTree() {
        return examDao.getALLClassTree();
    }

    public List<Tree> getClassTreeByDepartmentId(String deptid) {
        return examDao.getClassTreeByDepartmentId(deptid);
    }

    public List<Dept> chooseDeptList(String ids) {
        return examDao.chooseDeptList(ids);
    }

    public List<ClassBean> chooseIdsList(String ids) {
        return examDao.chooseIdsList(ids);
    }


    public void insertExamCourseClass(ExamCourseClass examCourseClass) {
        examDao.insertExamCourseClass(examCourseClass);
    }

    public List<ExamCourseClass> getSelectedClassById(String examCourseId) {
        return examDao.getSelectedClassById(examCourseId);
    }

    public void deleteOriginalExamCourseClass(String examCourseId) {
        examDao.deleteOriginalExamCourseClass(examCourseId);
    }

    public List<Tree> getAllEmpTree() {
        return examDao.getAllEmpTree();
    }

    public List<Emp> chooseEmpList(String dept_id, @Param("ids") String ids) {
        return examDao.chooseEmpList(dept_id, ids);
    }

    public void insertExamTeacher(ExamTeacher examTeacher) {
        examDao.insertExamTeacher(examTeacher);
    }

    public List<ExamTeacher> getSelectedEmpByExamId(String examId) {
        return examDao.getSelectedEmpByExamId(examId);
    }

    public void deleteOriginalExamTeacher(String examId) {
        examDao.deleteOriginalExamTeacher(examId);
    }

    public List<ExamCourseClass> getExamClassByExamId(String examId) {
        return examDao.getExamClassByExamId(examId);
    }

    public List<ExamStudent> getExamStudentList(ExamStudent examStudent) {
        return examDao.getExamStudentList(examStudent);
    }

    public List<Student> getStudentListByClassId(String classId) {
        return examDao.getStudentListByClassId(classId);
    }

    public void insertExamStudent(ExamStudent examStudent) {
        examDao.insertExamStudent(examStudent);
    }

    public void deleteOriginalExamStudent(String examId) {
        examDao.deleteOriginalExamStudent(examId);
    }

    public List<ExamRoom> getExamRoomList(ExamRoom examRoom) {
        return examDao.getExamRoomList(examRoom);
    }

    public void insertExamRoom(ExamRoom examRoom) {
        examDao.insertExamRoom(examRoom);
    }

    public void updateExamRoom(ExamRoom examRoom) {
        examDao.updateExamRoom(examRoom);
    }

    public void delExamRoomById(String id) {
        examDao.delExamRoomById(id);
    }

    public ExamRoom selectExamRoomById(String id) {
        return examDao.selectExamRoomById(id);
    }

    public List<ExamRoom> getExamRoomById(String roomId, String examId) {
        return examDao.getExamRoomById(roomId, examId);
    }

    public List<ExamCourse> getExamCourseById(String examId, String courseId) {
        return examDao.getExamCourseById(examId, courseId);
    }

    public List<ExamCourse> checkExamCourseStartTimeById(String courseId, String examId, String startTime) {
        return examDao.checkExamCourseStartTimeById(courseId, examId, startTime);
    }

    public List<ExamCourse> checkExamCourseEndTimeById(String examId, String endTime) {
        return examDao.checkExamCourseEndTimeById(examId, endTime);
    }

    public String getExamTeacherCountByExamId(String examId) {
        return examDao.getExamTeacherCountByExamId(examId);
    }

    public String getExamRoomTeacherSumByExamId(String examId) {
        return examDao.getExamRoomTeacherSumByExamId(examId);
    }

    public String getExamRoomStudentSumByExamId(String examId) {
        return examDao.getExamRoomStudentSumByExamId(examId);
    }

    public String getExamStudentCountByExamId(String examId) {
        return examDao.getExamStudentCountByExamId(examId);
    }

    public List<ExamArray> getTeacherArrayList(ExamArray examArray) {
        return examDao.getTeacherArrayList(examArray);
    }

    public ExamArray selectTeacherArrayById(String id) {
        return examDao.selectTeacherArrayById(id);
    }

    public void insertExamArray(ExamArray examArray) {
        examDao.insertExamArray(examArray);
    }

    public void updateTeacherArray(ExamArray examArray) {
        examDao.updateTeacherArray(examArray);
    }

    public List<ExamArrayStudent> getStudentArrayList(ExamArrayStudent examArrayStudent) {
        return examDao.getStudentArrayList(examArrayStudent);
    }

    public void deleteTeacherArray(String id) {
        examDao.deleteTeacherArray(id);
    }

    public List<Exam> checkExamListAutoPossibility(String examId) {
        return examDao.checkExamListAutoPossibility(examId);
    }

    public void changeExamFlag(Exam exam) {
        examDao.changeExamFlag(exam);
    }

    public List<ExamArrayStudent> checkExamArrayStudentListAutoPossibility(String examId) {
        return examDao.checkExamArrayStudentListAutoPossibility(examId);
    }


    public List<ExamStudent> selectExamStudentByClassId(String examId, String classId) {
        return examDao.selectExamStudentByClassId(examId, classId);
    }

    public void insertExamArrayStudent(ExamArrayStudent examArrayStudent) {
        examDao.insertExamArrayStudent(examArrayStudent);
    }

    public List<ExamStudent> getExamStudentById(String examId) {
        return examDao.getExamStudentById(examId);
    }

    public String getExamRoomClassNumByExamId(String examId) {
        return examDao.getExamRoomClassNumByExamId(examId);
    }

    public String getExamStudentClassCountByExamId(String examId) {
        return examDao.getExamStudentClassCountByExamId(examId);
    }

    public List<ExamStudent> selectExamStudentInsideOfExamRoom(String examId) {
        return examDao.selectExamStudentInsideOfExamRoom(examId);
    }

    public List<ExamStudent> selectExamStudentOutsideOfExamRoom(String examId) {
        return examDao.selectExamStudentOutsideOfExamRoom(examId);
    }

    public List<ExamRoom> getExamRoomByClassId(String examId, String classId) {
        return examDao.getExamRoomByClassId(examId, classId);
    }

    public ExamArrayStudent selectStudentArrayById(String id) {
        return examDao.selectStudentArrayById(id);
    }

    public void updateStudentArray(ExamArrayStudent examArrayStudent) {
        examDao.updateStudentArray(examArrayStudent);
    }

    public List<ClassBean> getClassBeanPropertyForBatchAddExamRoom(String examId) {
        return examDao.getClassBeanPropertyForBatchAddExamRoom(examId);
    }

    public void deleteOriginalExamRoom(String examId) {
        examDao.deleteOriginalExamRoom(examId);
    }

    public void delExamArrayById(String id) {
        examDao.delExamArrayById(id);
    }

    public void delExamArrayStudentById(String id) {
        examDao.delExamArrayStudentById(id);
    }

    public String getClassRoomByClassId(String classId) {
        return examDao.getClassRoomByClassId(classId);
    }

    public Classroom selectClassRoomById(String roomId) {
        return examDao.selectClassRoomById(roomId);

    }

    @Override
    public String getAllExamRoomClassNumByExamId(String examId) {
        return examDao.getAllExamRoomClassNumByExamId(examId);
    }

    @Override
    public String getAllExamCourseClassNumByExamId(String examId) {
        return examDao.getAllExamCourseClassNumByExamId(examId);
    }

    @Override
    public List<ExamCourseClass> findExamCourseListByExamId(String examId) {
        return examDao.findExamCourseListByExamId(examId);
    }

    @Override
    public List<ExamCourseClass> findExamCourseListByClassId(String classId) {
        return examDao.findExamCourseListByClassId(classId);
    }

    @Override
    public ExamRoomClass selectExamRoomTeacherByExamIdAndClassId(String examId, String classId) {
        return examDao.selectExamRoomTeacherByExamIdAndClassId(examId, classId);
    }


    public List<ExamTeacher> getExamTeacherById(String examId) {
        return examDao.getExamTeacherById(examId);
    }

    public void insertExamRoomTeacher(ExamRoomTeacher examRoomTeacher) {
        examDao.insertExamRoomTeacher(examRoomTeacher);
    }

    public List<Tree> getEmpTreeForHandWork(String examId) {
        return examDao.getEmpTreeForHandWork(examId);
    }

    public List<ExamRoomTeacher> getSelectedEmpTreeByExamIdAndRoomId(String examId, String roomId) {
        return examDao.getSelectedEmpTreeByExamIdAndRoomId(examId, roomId);
    }

    public void deleteOriginalExamRoomTeacher(String examId) {
        examDao.deleteOriginalExamRoomTeacher(examId);
    }

    public List<ExamRoomTeacher> getExamRoomTeacherByExamRoomId(String id) {
        return examDao.getExamRoomTeacherByExamRoomId(id);
    }

    public String getOriginalTeacherNum(String examId, String roomId) {
        return examDao.getOriginalTeacherNum(examId, roomId);
    }

    public String getSelectedEmpSize(String ids) {
        return examDao.getSelectedEmpSize(ids);
    }

    public void updateExamRoomTeacherByRoomIdForHandWork(ExamRoomTeacher examRoomTeacher) {
        examDao.updateExamRoomTeacherByRoomIdForHandWork(examRoomTeacher);
    }

    public void delExamStduentById(String id) {
        examDao.delExamStduentById(id);
    }

    public List<AutoComplete> autoCompleteStudent() {
        return examDao.autoCompleteStudent();
    }

    public Classroom getPeopleNumber(String roomId) {
        return examDao.getPeopleNumber(roomId);
    }

    public List<Tree> getExamRoomClassTree() {
        return examDao.getExamRoomClassTree();
    }

    public void deleteOriginalExamClass(ExamClass examClass) {
        examDao.deleteOriginalExamClass(examClass);
    }

    public List<ClassBean> chooseClassList(@Param("majorCode") String majorCode, @Param("ids") String ids) {
        return examDao.chooseClassList(majorCode, ids);
    }

    public void insertExamClass(ExamClass examClass) {
        examDao.insertExamClass(examClass);
    }

    public List<ExamClass> getSelectedClassByExamRoomId(ExamClass examClass) {
        return examDao.getSelectedClassByExamRoomId(examClass);
    }

    public Integer getStudentNumberByClassId(@Param("ids") String ids) {
        return examDao.getStudentNumberByClassId(ids);
    }

    public Integer getPeopleNumberByExamId(String examRoomId) {
        return examDao.getPeopleNumberByExamId(examRoomId);
    }

    public List<Major> chooseMajorList(@Param(value = "dept_id") String dept_id, @Param(value = "ids") String ids) {
        return examDao.chooseMajorList(dept_id, ids);
    }

    public List<String> getClassIdByRoom(ExamClass examClass) {
        return examDao.getClassIdByRoom(examClass);
    }

    public String getRoomTypeByExamRoomId(String examRoomId) {
        return examDao.getRoomTypeByExamRoomId(examRoomId);
    }

    public List<Tree> getExamCourseClassTree(ExamCourse examCourse) {
        return examDao.getExamCourseClassTree(examCourse);
    }

    public List<ExamCourse> getSelectedCourseByExamRoomId(ExamCourse examCourse) {
        return examDao.getSelectedCourseByExamRoomId(examCourse);
    }

    public List<ExamClass> getExamClassByExamRoom(ExamRoom examRoom) {
        return examDao.getExamClassByExamRoom(examRoom);
    }

    public List<Course> chooseCourseList(@Param(value = "majorCode") String majorCode, @Param(value = "ids") String ids) {
        return examDao.chooseCourseList(majorCode, ids);
    }

    public void deleteOriginalExamCourse(ExamCourse examCourse) {
        examDao.deleteOriginalExamCourse(examCourse);
    }

    public List<ExamCourse> getExamCourseByIds(String ids) {
        return examDao.getExamCourseByIds(ids);
    }

    public void saveExamCourseTime(ExamCourse examCourse) {
        examDao.saveExamCourseTime(examCourse);
    }


    public List<Tree> getExamCourseExamClassTree(ExamCourseClass examCourseClass) {
        return examDao.getExamCourseExamClassTree(examCourseClass);
    }

    public void deleteOriginalExamCourseExamClass(ExamCourseClass examCourseClass) {
        examDao.deleteOriginalExamCourseExamClass(examCourseClass);
    }

    public List<ClassBean> chooseCourseClassList(@Param("majorCode") String majorCode, @Param("ids") String ids) {
        return examDao.chooseCourseClassList(majorCode, ids);
    }

    public void insertExamCourseExamClass(ExamCourseClass examCourseClass) {
        examDao.insertExamCourseExamClass(examCourseClass);
    }

    public List<ExamCourseClass> getSelectedClassByExamCourseClass(ExamCourseClass examCourseClass) {
        return examDao.getSelectedClassByExamCourseClass(examCourseClass);
    }

    public Integer getTeacherNumberByExamRoom(String examId) {
        return examDao.getTeacherNumberByExamRoom(examId);
    }

    public String getTeacherNumberByExamTeacherCourse() {
        return examDao.getTeacherNumberByExamTeacherCourse();
    }

    public List<ExamArray> getExamCourseRoomTeacherList(ExamArray ExamArray) {
        return examDao.getExamCourseRoomTeacherList(ExamArray);
    }

    public List<ExamCourse> getExamCourseByExamRoom(ExamRoom examRoom) {
        return examDao.getExamCourseByExamRoom(examRoom);
    }

    public String getTeacherPersonIdByExamRoomTeacher(ExamRoomTeacher examRoomTeacher) {
        return examDao.getTeacherPersonIdByExamRoomTeacher(examRoomTeacher);
    }

    public String getExamCourseNum(String examId) {
        return examDao.getExamCourseNum(examId);
    }

    public String getExamCourseTime(String examId) {
        return examDao.getExamCourseTime(examId);
    }

    public String getExamClassByExamCourse(String examId) {
        return examDao.getExamClassByExamCourse(examId);
    }

    @Override
    public ExamCourseClass getExamCourseClassById(String id) {
        return examDao.getExamCourseClassById(id);
    }

    @Override
    public void delExamCourseClassById(String id) {
        examDao.delExamCourseClassById(id);
    }

    @Override
    public void updateExamCourseClass(ExamCourseClass examCourseClass) {
        examDao.updateExamCourseClass(examCourseClass);
    }

    @Override
    public List<ExamCourseClass> getExamCourseClass(ExamCourseClass examCourseClass) {
        return examDao.getExamCourseClass(examCourseClass);
    }

    @Override
    public List getExamTime(ExamTime examTime) {
        return examDao.getExamTime(examTime);
    }

    @Override
    public ExamTime getExamTimeById(String id) {
        return examDao.getExamTimeById(id);
    }

    @Override
    public void delExamTimeById(String id) {
        examDao.delExamTimeById(id);
    }

    @Override
    public void updateExamTime(ExamTime examTime) {
        examDao.updateExamTime(examTime);
    }

    @Override
    public void insertExamTime(ExamTime examTime) {
        examDao.insertExamTime(examTime);
    }

    @Override
    public Integer autoAddStudent(String examId) {
        return examDao.autoAddStudent(examId);
    }

    @Override
    public void saveStatus(String id, String status) {
        examDao.saveStatus(id, status);
    }

    @Override
    public List<Tree> getEmpsTree(String id) {
        return examDao.getEmpsTree(id);
    }

    @Override
    public void saveEmps(ExamTeacher examTeacher) {
        examDao.saveEmps(examTeacher);
    }

    @Override
    public void deleteExamTeacherByExamId(String id) {
        examDao.deleteExamTeacherByExamId(id);
    }

    @Override
    public List<ExamTime> getExamTimeByExamId(String examId) {
        return examDao.getExamTimeByExamId(examId);
    }

    @Override
    public List<ExamCourseClass> getExamCourseClassByExamId(String examId) {
        return examDao.getExamCourseClassByExamId(examId);
    }

    @Override
    public List<ExamStudent> getStudentsByExamId(String examId) {
        return examDao.getStudentsByExamId(examId);
    }

    @Override
    public List<ExamTeacher> getExamTeacherByEaxmId(String examId) {
        return examDao.getExamTeacherByEaxmId(examId);
    }

    @Override
    public List<ExamArray> getExamRoomByExamId(String examId) {
        return examDao.getExamRoomByExamId(examId);
    }

    @Override
    public Integer updateExamArray(String examId) {
        return examDao.updateExamArray(examId);
    }

    @Override
    public void deleteExamArrayStudentByExamId(String examId) {
        examDao.deleteExamArrayStudentByExamId(examId);
    }

    @Override
    public List<ExamArrayStudent> getExamArrayStudentsByCurrent(String date, String startTime, String endTime, String examId) {
        return examDao.getExamArrayStudentsByCurrent(date, startTime, endTime, examId);
    }

    @Override
    public List<ExamStudent> getStudents(ExamStudent examStudent) {
        return examDao.getStudents(examStudent);
    }

    @Override
    public void delExamStudentById(String id) {
        examDao.delExamStudentById(id);
    }

    @Override
    public List<ExamCourseClass> getExamCourseClassByClassIdAndCourseId(String classId, String courceId, String examId) {
        return examDao.getExamCourseClassByClassIdAndCourseId(classId, courceId, examId);
    }

    @Override
    public void updateExamCourseStudent(ExamStudent examStudent) {
        examDao.updateExamCourseStudent(examStudent);
    }

    @Override
    public void insertExamCourseStudent(ExamStudent examStudent) {
        examDao.insertExamCourseStudent(examStudent);
    }

    @Override
    public ExamStudent getStudentById(String id, String examId, String courseId) {
        return examDao.getStudentById(id, examId, courseId);
    }

    @Override
    public List<ExamArray> getResult(String examId) {
        return examDao.getResult(examId);
    }

    @Override
    public List<String> getDate(String examId) {
        return examDao.getDate(examId);
    }

    @Override
    public int importClassData(String id) {
        return examDao.importClassData(id);
    }

    @Override
    public void deleteExamCourseClassByExamId(String id) {
        examDao.deleteExamCourseClassByExamId(id);
    }

    @Override
    public List<ExamStudent> getExamStudentByStudentIdAndCourseIdAndTerm(String studentId, String courseId, String examId, String term, String examTypes) {
        return examDao.getExamStudentByStudentIdAndCourseIdAndTerm(studentId, courseId, examId, term, examTypes);
    }

    @Override
    public List<ExamCourseClass> examServicegetExamCourseClassFromExamStudent(String examId, String examTypes) {
        return examDao.examServicegetExamCourseClassFromExamStudent(examId, examTypes);
    }

    @Override
    public void importExamCourseClassData(String examId) {
        examDao.importExamCourseClassData(examId);
    }

    @Override
    public List<ExamStudent> getExamStudentByCalssIdAndCourseId(String classId, String courseId, String examId) {
        return examDao.getExamStudentByCalssIdAndCourseId(classId, courseId,examId);
    }

    @Override
    public List<Select2> getTeachers(String id, String examId) {
        return examDao.getTeachers(id, examId);
    }

    @Override
    public void updateTeacher(String id, String teacherId, String teacherDept) {
        examDao.updateTeacher(id, teacherId, teacherDept);
    }

    @Override
    public List<Select2> getRooms(String id, String examId) {
        return examDao.getRooms(id, examId);
    }

    @Override
    public void updateStudentRoom(String id, String roomId) {
        examDao.updateStudentRoom(id, roomId);
    }

    @Override
    public List<Tree> getExamTree(String examId) {
        return examDao.getExamTree(examId);
    }

    @Override
    @Transactional
    public int importStudent(String examId, String examIds, String examTypes) {
//        如果是毕业前补考
        if (examTypes.equals("毕业前补考")){
            String[] eidArray = examIds.split(",");
            int count = 0 ;
            for (String eid:eidArray) {
                Exam exam1 = examDao.selectExamById(eid);

                String examTypesValue = exam1.getExamTypes();
                count += examDao.importStudent(examId, eid, examTypes,examTypesValue);
            }
            return  count;
        }else {
            examIds = examIds.replaceAll(",", "','");
            return examDao.importStudent(examId, examIds, examTypes,null);
        }
    }

    @Override
    public int importClassDataByStudent(String examId) {
        return examDao.importClassDataByStudent(examId);
    }

    @Override
    public boolean checkScoreTime(String examId) {
        return examDao.getScoreTime(examId, new SimpleDateFormat("yyyy-MM-dd").format(new Date())).size() > 0;
    }

    @Override
    public List<ExamArray> getExaminationList(ExamArray examArray) {
        return examDao.getExaminationList(examArray);
    }

    @Override
    public List<String> getEdate(String examId) {
        return examDao.getEdate(examId);
    }

    @Override
    public ExamArray getExaminationById(String id) {
        return examDao.getExaminationById(id);
    }

    @Override
    public void updateExamination(ExamArray examArray) {
        examDao.updateExamination(examArray);
    }

    @Override
    public void insertExamination(ExamArray examArray) {
        examDao.insertExamination(examArray);
    }

    @Override
    public void delExamination(String id) {
        examDao.delExamination(id);
    }

    @Override
    public ExamStudent getEaxmStudent(String courseId, String classId, String studentId, String term) {
        return examDao.getEaxmStudent(courseId, classId, studentId, term);
    }

    @Override
    public void deleteExamStudentByExamId(String examId) {
        examDao.deleteExamStudentByExamId(examId);
    }
}

