package com.goisan.system.service.impl;

import com.goisan.system.bean.CommonGroup;
import com.goisan.system.bean.CommonGroupMember;
import com.goisan.system.bean.EmpDeptTree;
import com.goisan.system.dao.CommonGroupDao;
import com.goisan.system.service.CommonGroupService;
import com.goisan.system.tools.CommonUtil;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by admin on 2017/6/30.
 */
@Service
public class CommonGroupServiceImpl implements CommonGroupService {

    @Resource
    private CommonGroupDao commonGroupDao;
    public List<CommonGroup> getGroupList(CommonGroup commomGroup){
        return commonGroupDao.getGroupList(commomGroup);
    }

    public void insertGroup(CommonGroup commomGroup){
        commonGroupDao.insertGroup(commomGroup);
    }

    public void updateGroup(CommonGroup commomGroup){
        commonGroupDao.updateGroup(commomGroup);
    }

    public CommonGroup getGroupById(String groupId){
        return commonGroupDao.getGroupById(groupId);
    }

    public List<EmpDeptTree> getGroupEmpTree(String groupId){
        return commonGroupDao.getGroupEmpTree(groupId);
    }

    public void delCommonGroupMember(String groupId){
        commonGroupDao.delCommonGroupMember(groupId);
    }

    public void insertCommonGroupMember(CommonGroupMember commonGroupMember){
        commonGroupDao.insertCommonGroupMember(commonGroupMember);
    }

    public void delCommonGroup(String groupId){
        commonGroupDao.delCommonGroup(groupId);
    }

    public List<CommonGroup> getGroupRole(String groupId){
        return commonGroupDao.getGroupRole(groupId);
    }

    public void insertGroupRole(CommonGroup commomGroup){
        commonGroupDao.delGroupRole(commomGroup.getGroupId());
        String roleId = commomGroup.getRoleId();
        String[] roleList = roleId.split(",");
        commomGroup.setCreator(CommonUtil.getPersonId());
        commomGroup.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        commomGroup.setCreateTime(CommonUtil.getDate());
        for (int i = 0; i < roleList.length; i++) {
            commomGroup.setRoleId(roleList[i]);
            commonGroupDao.insertGroupRole(commomGroup);
        }
    }

    public void delGroupRole(String groupId){
        commonGroupDao.delGroupRole(groupId);
    }

    public List getGroupMenu(String groupId){
        return commonGroupDao.getGroupMenu(groupId);
    }

    public List<String> getGroupIdByPersonId(String personId){
        return commonGroupDao.getGroupIdByPersonId(personId);
    }

    public List<String> getRoleIdByGroupIds(@Param("ids")String ids){
        return commonGroupDao.getRoleIdByGroupIds(ids);
    }
}





