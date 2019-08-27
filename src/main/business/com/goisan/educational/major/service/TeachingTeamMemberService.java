package com.goisan.educational.major.service;

import com.goisan.educational.major.bean.TeachingTeamMember;

import java.util.List;

/**
 * @author 郭千恺
 * @version v1.0
 * @descroption 专业教学团队成员
 * @date 2018/10/11 9:40
 */
public interface TeachingTeamMemberService {
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
    boolean insert(TeachingTeamMember teachingTeamMember);

    /**
     * 删除成员
     * @param id
     */
    boolean delete(String id);
}
