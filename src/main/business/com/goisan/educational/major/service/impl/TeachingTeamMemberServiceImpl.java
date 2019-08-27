package com.goisan.educational.major.service.impl;

import com.goisan.educational.major.bean.TeachingTeamMember;
import com.goisan.educational.major.dao.TeachingTeamMemberDao;
import com.goisan.educational.major.service.TeachingTeamMemberService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author 郭千恺
 * @version v1.0
 * @descroption 专业教学团队成员
 * @date 2018/10/11 9:41
 */
@Service
public class TeachingTeamMemberServiceImpl implements TeachingTeamMemberService {
    @Resource
    private TeachingTeamMemberDao teachingTeamMemberDao;

    /**
     * 获取成员列表
     * @param teachingTeamMember
     * @return
     */
    public List<TeachingTeamMember> getList(TeachingTeamMember teachingTeamMember) {
        try {
            return this.teachingTeamMemberDao.getList(teachingTeamMember);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 新增成员
     * @param teachingTeamMember
     */
    public boolean insert(TeachingTeamMember teachingTeamMember) {
        try {
            this.teachingTeamMemberDao.insert(teachingTeamMember);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 删除成员
     * @param id
     */
    public boolean delete(String id) {
        try {
            this.teachingTeamMemberDao.delete(id);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
