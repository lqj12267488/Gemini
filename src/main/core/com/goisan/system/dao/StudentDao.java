package com.goisan.system.dao;

import com.goisan.system.bean.ClassStudentRelation;
import com.goisan.system.bean.Student;
import com.goisan.system.bean.Tree;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2017/5/20.
 */
@Repository
public interface StudentDao {
    Student getStudentByIdcard(@Param("idcard") String idcard);
    List<Student> getStudentList(Student student);

    Student getStudentById(String studentId);

    String getDepartmentsIdByStudentId(String studentId);

    String getMajorCodeByMajorName(String majorName);

    Student getStudentNameByStudentId(String studentId);

    void insertStudent(Student student);

    void updateStudent(Student student);

    void delStudent(String studentId);

    void delClassStudentRelation(String studentId);

    void delRoleByStudentId(String studentId);

    List<Tree> getMajorClassTree();
    List<Tree> getMajorClassTree2();
    List<Tree> getMajorClassTree3();

    List<Tree> getMajorClassTreeByLevel(@Param("level") String level);

    List<Tree> getDeptMajorGradClassTree(@Param("level") String level);


    void addRelation(ClassStudentRelation relation);

    List<ClassStudentRelation> getClassStudentRelation(String studentId);

    String getTreeTable(String id);

    List checkIdCard(String idcard);

    List checkStudentNumber(String studentNumber);

    void insertClassStudentRelation(@Param("studentId") String studentId, @Param("classids") String[] relationids);

    List<Student> getStudentListByDept(
            @Param("deptId") String deptId, @Param("deptIdLike") String deptIdLike,
            @Param("name") String name, @Param("idcard") String idcard, @Param("level") String level);


    List<Student> getStudentListByDept2(@Param("deptId") String deptId);
    List<Student> getGradStudentListByDept(@Param("deptId") String deptId);

    List<Student> getStudentListByMajor(
            @Param("majorCode") String majorCode, @Param("name") String name,
            @Param("idcard") String idcard, @Param("level") String level);

    List<Student> getGradStudentListByMajor(@Param("majorCode") String majorCode);
    List<Student> getStudentListByMajor2(@Param("majorCode") String majorCode);

    List<Tree> getStudentTree(String roleId);

    List<Student> findStudentListByStudentId(@Param("ids") String ids);

    void updateRelation(ClassStudentRelation relation);

    void batchUpdateRelation(@Param("ids") String ids, @Param("classId") String classId);

    List<Student> getPaymentInfoStandardList(String id);

    List<Student> getStudentStatisticsList(Student student);

    String getClassNameByClassId(String class_id);

    String getClassIdByClassName(String className);

    Student getStudentByCandidateNumber(String candidateNumber);

    Student getStudentByStudentNumber(String studentNumber);

    List<Student> exportStudent(Map<String, Object> param);

    Student getStudentByIdNoClassId(String studentId);

    List<Map<String, Object>> checkStudentById(String studentId);

    String getStudentNumByClassId(String classId);

    void updateUser(@Param("studentId") String studentId,@Param("classId") String classId);
}
