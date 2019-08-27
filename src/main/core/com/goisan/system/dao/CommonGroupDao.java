package com.goisan.system.dao;

import com.goisan.system.bean.CommonGroup;
import com.goisan.system.bean.CommonGroupMember;
import com.goisan.system.bean.EmpDeptTree;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by admin on 2017/6/30.
 */
@Repository
public interface CommonGroupDao {

    List<CommonGroup> getGroupList(CommonGroup commomGroup);

    void insertGroup(CommonGroup commomGroup);

    void updateGroup(CommonGroup commomGroup);

    CommonGroup getGroupById(String groupId);

    List<EmpDeptTree> getGroupEmpTree(String groupId);

    void delCommonGroupMember(String groupId);

    void insertCommonGroupMember(CommonGroupMember commonGroupMember);

    void delCommonGroup(String groupId);
    
    List<CommonGroup> getGroupRole(String groupId);

    void insertGroupRole(CommonGroup commomGroup);

    void delGroupRole(String groupId);

    List getGroupMenu(String groupId);

    List<String> getGroupIdByPersonId(String personId);

    List<String> getRoleIdByGroupIds(@Param("ids")String ids);
}
