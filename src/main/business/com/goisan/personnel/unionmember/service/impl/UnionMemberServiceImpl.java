package com.goisan.personnel.unionmember.service.impl;

import com.goisan.personnel.unionmember.bean.UnionMember;
import com.goisan.personnel.unionmember.dao.UnionMemberDao;
import com.goisan.personnel.unionmember.service.UnionMemberService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by hanyu on 2017/9/19.
 */
@Service
public class UnionMemberServiceImpl implements UnionMemberService{
    @Resource
    private UnionMemberDao unionMemberDao;

    public List<UnionMember> getUnionMemberList(UnionMember unionMember){
        return unionMemberDao.getUnionMemberList(unionMember);
    }

    public UnionMember getUnionMemberById(String id){
        return unionMemberDao.getUnionMemberById(id);
    }

    public void insertUnionMember(UnionMember unionMember){
        unionMemberDao.insertUnionMember(unionMember);
    }

    public void updateUnionMember(UnionMember unionMember){
        unionMemberDao.updateUnionMember(unionMember);
    }

    public void deleteUnionMember(UnionMember unionMember){
        unionMemberDao.deleteUnionMember(unionMember);
    }

    public List<UnionMember> getUnionNumber(UnionMember unionMember){
        return unionMemberDao.getUnionNumber(unionMember);
    }

    public List<UnionMember> getPersonIdDeptId(UnionMember unionMember){
        return unionMemberDao.getPersonIdDeptId(unionMember);
    }

}
