package com.goisan.suggestionbox.dao;

import com.goisan.suggestionbox.bean.ReplyForSuggestion;
import com.goisan.suggestionbox.bean.TeacherSuggestion;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @descroption 教师意见
 * @author 郭千恺
 * @version v1.0
 * @date 2018/9/26 15:47
 */
@Repository
public interface TeacherSuggestionDao {
    /**
     * 获取教师意见列表
     * @param teacherSuggestion
     * @return
     */
    List<TeacherSuggestion> getList(TeacherSuggestion teacherSuggestion);

    void updateViewFlag(String id);

    /**
     * 新增教师意见
     * @param teacherSuggestion
     */
    void insert(TeacherSuggestion teacherSuggestion);

    /**
     * 更新教师意见
     * @param teacherSuggestion
     */
    void update(TeacherSuggestion teacherSuggestion);

    /**
     * 按id获取教师意见
     * @param id
     * @return
     */
    TeacherSuggestion getById(String id);

    /**
     * 删除教师意见
     * @param id
     */
    void del(String id);

    /**
     * 回复教师意见
     * @param replyForSuggestion
     */
    void reply(ReplyForSuggestion replyForSuggestion);

    /**
     * 修改回复标识
     * @param teacherSuggestion
     */
    void changeFlag(TeacherSuggestion teacherSuggestion);

    /**
     * 按id获取回复
     * @param id
     * @return
     */
    ReplyForSuggestion getReplyById(String id);

    /**
     * 更新回复
     * @param replyForSuggestion
     */
    void updateReply(ReplyForSuggestion replyForSuggestion);

    /**
     * 删除回复
     * @param id
     */
    void delReply(String id);
}
