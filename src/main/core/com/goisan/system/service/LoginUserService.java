package com.goisan.system.service;

import com.goisan.system.bean.LoginUser;

/**
 * Created by Admin on 2017/4/15.
 */
public interface LoginUserService {

    LoginUser getLoginUserByLoginId(String id);

    LoginUser getLoginUserById(String id);

    LoginUser getLoginUserRolesByLoginId(String id);

    void upadtedefaultDeptId(String userAccount, String deptId);

    void upadtedefaultDeptByPersonid(String personId, String deptId);


    String getUserAccount(String userAccount);

    void upadtedeLoginUser(LoginUser LoginUser);

    void deleteloginUser(String personId);

    void deleteUser(String personId);

    LoginUser getStudentRolesByLoginId(String userAccount);

    LoginUser getParentStudentUserRolesByLoginId(String userAccount);

    void saveUser(LoginUser loginUser);

    void savePhoto(LoginUser loginUser);

    void deleteStudentUserAcountByStudentId(String studentId);

    void recoveryLoginUser(String personId);

    String getTheme(LoginUser user, String system);

    void updateTheme(LoginUser user, String system);

    String selectPersonIdByTel(String username);

    String selectPasswordByPersonId(String personId);
}
