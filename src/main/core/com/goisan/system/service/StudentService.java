package com.goisan.system.service;

import com.goisan.system.bean.ClassStudentRelation;
import com.goisan.system.bean.Student;
import com.goisan.system.bean.Tree;
import org.apache.ibatis.annotations.Param;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2017/5/20.
 */
public interface StudentService {
    List<Student> getStudentList(Student student);

    Student getStudentByIdcard(String idcard);

    Student getStudentById(String studentId);

    String getDepartmentsIdByStudentId(String studentId);

    Student getStudentNameByStudentId(String studentId);

    String getMajorCodeByMajorName(String majorName);

    void insertStudent(Student student);

    void updateStudent(Student student);

    void delStudent(String studentId);

    void delClassStudentRelation(String studentId);

    void delRoleByStudentId(String studentId);

    List<Tree> getMajorClassTree();


    List<Tree> getMajorClassTreeByLevel(String level);

    void addRelation(ClassStudentRelation relation);

    List<ClassStudentRelation> getClassStudentRelation(String studentId);

    String getTreeTable(String id);

    List checkIdCard(String idcard);

    List checkStudentNumber(String studentNumber);

    void saveClassStudentRelation(String studentId, String relationids);

    List<Student> getStudentListByDept(String deptId, String deptIdLike, String name, String idcard, String level);

    List<Student> getStudentListByMajor(String majorCode, String name, String idcard, String level);

    List<Tree> getStudentTree(String roleId);

    List<Student> findStudentListByStudentId(String ids);

    List<Student> getPaymentInfoStandardList(String id);

    List<Student> getStudentStatisticsList(Student student);

    String getClassNameByClassId(String class_id);

    String getClassIdByClassName(String className);

    HSSFWorkbook getStudentExcelTemplate(String type);

    HSSFWorkbook getStudentExcelTemplate1();

    Student getStudentByCandidateNumber(String candidateNumber);

    Student getStudentByStudentNumber(String studentNumber);

    List<Student> exportStudent(Map<String, Object> param);

    Student getStudentByIdNoClassId(String studentId);

    List<Map<String, Object>> checkStudentById(String studentId);

    String getStudentNumByClassId(String classId);

    void updateUser(@Param("studentId") String studentId,@Param("classId") String classId);

    /**获取系部专业，毕业班级，待毕业班级*/
    List<Tree> getDeptMajorGradClassTree(String level);
}
