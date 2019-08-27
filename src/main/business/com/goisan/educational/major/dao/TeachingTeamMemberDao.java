package com.goisan.educational.major.dao;

import com.goisan.educational.major.bean.TeachingTeamMember;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author 郭千恺
 * @version v1.0
 * @descroption 专业教学团队成员
 * @date 2018/10/11 9:02
 */
@Repository
public interface TeachingTeamMemberDao {
    /**
     * 获取成员列表
     * @param teachingTeamMember
     * @return
     */
    List<TeachingTeamMember> getList(TeachingTeamMember teachingTeamMember);

    /**
     * 新增成员
     * @param teachingTeamMember
     */
    void insert(TeachingTeamMember teachingTeamMember);

    /**
     * 删除成员
     * @param id
     */
    void delete(String id);
}
