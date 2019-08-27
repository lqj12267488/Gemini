package com.goisan.personnel.unionmember.dao;


import com.goisan.personnel.unionmember.bean.UnionMember;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by hanyu on 2017/9/19.
 */
@Repository
public interface UnionMemberDao {
    List<UnionMember> getUnionMemberList(UnionMember unionMember);

    UnionMember getUnionMemberById(String id);

    void insertUnionMember(UnionMember unionMember);

    void updateUnionMember(UnionMember unionMember);

    void deleteUnionMember(UnionMember unionMember);

    List<UnionMember> getUnionNumber(UnionMember unionMember);

    List<UnionMember> getPersonIdDeptId(UnionMember unionMember);

}
