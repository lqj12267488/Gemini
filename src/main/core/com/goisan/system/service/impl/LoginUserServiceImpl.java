package com.goisan.system.service.impl;

import com.goisan.system.bean.LoginUser;
import com.goisan.system.dao.LoginUserDao;
import com.goisan.system.service.LoginUserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by Admin on 2017/4/15.
 */
@Service
public class LoginUserServiceImpl implements LoginUserService {

    @Resource
    private LoginUserDao loginUserDao;

    public LoginUser getLoginUserByLoginId(String id) {
        return loginUserDao.getLoginUserByLoginId(id);
    }

    public LoginUser getLoginUserById(String id) {
        return loginUserDao.getLoginUserById(id);
    }

    public LoginUser getLoginUserRolesByLoginId(String id) {
        return loginUserDao.getLoginUserRolesByLoginId(id);
    }

    public String getUserAccount(String userAccount) {
        return loginUserDao.getUserAccount(userAccount);
    }

    public void upadtedefaultDeptId(String userAccount, String deptId) {
        loginUserDao.upadtedefaultDeptId(userAccount, deptId);
    }

    public void upadtedefaultDeptByPersonid(String personId, String deptId) {
        loginUserDao.upadtedefaultDeptByPersonid(personId, deptId);
    }

    public void upadtedeLoginUser(LoginUser LoginUser) {
        loginUserDao.upadtedeLoginUser(LoginUser);
    }

    public void deleteloginUser(String personId) {
        loginUserDao.deleteloginUser(personId);
    }

    public void deleteUser(String personId) {
        loginUserDao.deleteUser(personId);
    }

    public LoginUser getStudentRolesByLoginId(String userAccount) {
        return loginUserDao.getStudentRolesByLoginId(userAccount);
    }

    public LoginUser getParentStudentUserRolesByLoginId(String userAccount) {
        return loginUserDao.getParentStudentUserRolesByLoginId(userAccount);
    }

    public void saveUser(LoginUser loginUser) {
        loginUserDao.saveUser(loginUser);
    }

    public void savePhoto(LoginUser loginUser) {
        loginUserDao.savePhoto(loginUser);
    }

    public void deleteStudentUserAcountByStudentId(String studentId) {
        loginUserDao.deleteStudentUserAcountByStudentId(studentId);
    }

    @Override
    public void recoveryLoginUser(String personId) {
        loginUserDao.recoveryLoginUser(personId);
    }

    @Override
    public void updateTheme(LoginUser user, String system) {
        loginUserDao.delTheme(user, system);
        loginUserDao.updateTheme(user, system);
    }

    @Override
    public String selectPersonIdByTel(String username) {
        return loginUserDao.selectPersonIdByTel(username);
    }

    @Override
    public String selectPasswordByPersonId(String personId) {
        return loginUserDao.selectPasswordByPersonId(personId);
    }

    @Override
    public String getTheme(LoginUser user, String system) {
        return loginUserDao.getTheme(user, system);
    }
}
