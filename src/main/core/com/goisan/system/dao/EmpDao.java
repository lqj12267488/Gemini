package com.goisan.system.dao;

import com.goisan.system.bean.*;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.sql.Blob;
import java.util.List;

/**
 * Created by Admin on 2017/4/20.
 */
@Repository
public interface EmpDao {

    Integer selEmpCountByName (String teacherName);
    List<Emp> getEmpList(Emp emp);

    String getStaffIdByPersonId(String personId);

    List<Emp> getEmpListByName(String name);

    void saveEmp(Emp emp);

    void saveEmpDeptRelation(EmpDeptRelation edr);

    List<Emp> getEmpListByDeptId(Emp emp);

    void deleteEmp(String personId);

    void deleteEmpDeptRelation(@Param("personId") String personId, @Param("deptId") String deptId);

    List<EmpDeptRelation> getDeptByDeptIdAndPersonId(@Param("personId") String personId,
                                                     @Param("deptId") String deptId);

    Emp getEmpByEmpId(String personId);

    Emp getEmpByDeptIdAndPersonId(@Param("personId") String personId,
                                  @Param("deptId") String deptId);

    void updateEmp(Emp emp);

    List<String> getDeptByPersonId(String personId);

    String getPersonNameById(String personId);

    String getPersonNameById1(String personId);

    String getDeptNameById(String deptId);

    void deleteEmpDept(String personId);

    Blob getPhotoByPersonid(String personId);

    List<Emp> GroupEmpByDept();

    List<String> getEmpRole(@Param("personId") String personId, @Param("deptId") String deptId);

    List<Tree> getRoleList();

    void deleteRoleByPersonIdAndDeptId(@Param("personId") String personId, @Param("deptId") String deptId);

    Emp getEmpByIdCard(String idCard);

    Emp getEmpByStaffId(String staffId);

    LoginUser getEmpByPersonId(String personId);

    List<Emp> getDeletedEmpList(Emp emp);

    void recoveryEmp(String personId);

    List<Emp> getStaffId(Emp emp);

    String getPersonLevel(String personId);

    void updateLevel(LoginUser loginUser);

    List<Select2> getLevels(int level);

    /**
     * 校验教师编号是否重复
     * @param staffId
     * @return
     */
    List<Emp> getEmpStaffId(String staffId);

    @Select("select dept_name from t_sys_dept")
    List<String> selectDeptName();

    @Select("SELECT e.person_id,\n" +
            "       e.sex,\n" +
            "       u.user_account,\n" +
            "       FUNC_GET_DICVALUE(e.sex, 'XB') sexShow,\n" +
            "       FUNC_GET_DICVALUE(e.job, 'GW') jobShow,\n" +
            "       e.entry_date entryDate,\n" +
            "       to_char(e.entry_date, 'yyyy-mm-dd') entryDateShow,\n" +
            "       FUNC_GET_DICVALUE(e.marital_status, 'HYZK') maritalStatusShow,\n" +
            "       e.levels levels,\n" +
            "       e.name,\n" +
            "       e.address,\n" +
            "       e.nation,\n" +
            "       FUNC_GET_DICVALUE(e.nation, 'MZ') nationShow,\n" +
            "       FUNC_GET_DICVALUE(e.sex, 'XB') sexShow,\n" +
            "       FUNC_GET_DICVALUE(e.ID_TYPE, 'SFZJLX') idTypeShow,\n" +
            "       e.IDCARD idCard,\n" +
            "       e.NATIVE_PLACE nativePlace,\n" +
            "       e.PERMANENT_RESIDENCE permanentResidence,\n" +
            "       e.PERMANENT_RESIDENCE_LOCAL permanentResidenceLocal,\n" +
            "       FUNC_GET_DICVALUE(e.EXAMINE_POLITICAL, 'SF') examinePoliticalShow,\n" +
            "       FUNC_GET_DICVALUE(e.political_status, 'ZZMM') politicalStatusShow,\n" +
            "       FUNC_GET_DICVALUE(e.EDUCATIONAL_LEVEL, 'WHCD') educationalLevelShow,\n" +
            "       FUNC_GET_DICVALUE(e.EDUCATION_TECHNIQUE, 'JYFS') educationTechniqueShow,\n" +
            "       e.GRADUATE_SCHOOL graduateSchool,\n" +
            "       e.major major,\n" +
            "       e.GRADUATE_TIME graduateTime,\n" +
            "       to_char(e.GRADUATE_TIME, 'yyyy-mm-dd') graduateTimeShow,\n" +
            "       e.POSITIONAL_TITLES positionalTitles,\n" +
            "       e.POSITIONAL_LEVEL positionalLevel,\n" +
            "       e.remark remark,\n" +
            "       e.birthday birthday,\n" +
            "       to_char(e.birthday, 'yyyy-mm-dd') birthdayShow,\n" +
            "       to_char(sysdate, 'YYYY') - to_char(e.birthday, 'YYYY') age,\n" +
            "       e.valid_flag,\n" +
            "       d.dept_id,\n" +
            "       d.dept_name,\n" +
            "       e.tel,\n" +
            "       e.STAFF_STATUS staffStatus,\n" +
            "       FUNC_GET_DICVALUE(e.STAFF_STATUS, 'JZGZT') staffStatusShow\n" +
            "  FROM t_rs_employee e, t_sys_dept d, t_rs_employee_dept ed, t_sys_user u\n" +
            " WHERE e.person_id = ed.person_id\n" +
            "   AND ed.dept_id = d.dept_id\n" +
            "   AND u.user_id = e.person_id\n" +
            "   AND e.valid_flag = '1'\n" +
            "   and d.dept_name = #{str}\n" +
            " ORDER BY u.USER_ACCOUNT")
    List<Emp> selectList(String str);
}
