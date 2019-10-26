package com.goisan.system.dao;

import com.goisan.system.bean.LoginUser;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * Created by Admin on 2017/4/15.
 */
@Repository
public interface LoginUserDao {

    LoginUser getLoginUserByLoginId(String id);

    LoginUser getLoginUserById(String id);

    LoginUser getLoginUserRolesByLoginId(String id);

    void upadtedefaultDeptId(@Param("userAccount") String userAccount, @Param("deptId") String deptId);

    void upadtedefaultDeptByPersonid(@Param("personId") String personId, @Param("deptId") String deptId);

    String getUserAccount(String userAccount);

    void saveUser(LoginUser loginUser);

    void upadtedeLoginUser(LoginUser LoginUser);

    void deleteloginUser(String personId);

    void deleteUser(String personId);

    LoginUser getStudentRolesByLoginId(String userAccount);

    LoginUser getParentStudentUserRolesByLoginId(String userAccount);

    void savePhoto(LoginUser loginUser);

    void deleteStudentUserAcountByStudentId(String studentId);

    void recoveryLoginUser(String personId);

    void updateTheme(@Param("user") LoginUser user, @Param("system") String system);

    String getTheme(@Param("user") LoginUser user, @Param("system") String system);

    void delTheme(@Param("user") LoginUser user, @Param("system") String system);

    String selectPersonIdByTel(String username);

    String selectPasswordByPersonId(String personId);
}
