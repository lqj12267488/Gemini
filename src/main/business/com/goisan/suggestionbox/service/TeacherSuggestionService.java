package com.goisan.suggestionbox.service;

import com.goisan.suggestionbox.bean.ReplyForSuggestion;
import com.goisan.suggestionbox.bean.TeacherSuggestion;

import java.util.List;

/**
 * 教师意见
 * @author 郭千恺
 * @version v1.0
 * @date 2018/9/26 15:48
 */
public interface TeacherSuggestionService {
    /**
     * 获取教师意见列表
     * @param teacherSuggestion
     * @return
     */
    List<TeacherSuggestion> getTeacherSuggestion(TeacherSuggestion teacherSuggestion);

    /**
     * 保存教师意见
     * @param teacherSuggestion
     */
    boolean save(TeacherSuggestion teacherSuggestion);

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

    void updateViewFlag(String id);

    /**
     * 回复教师意见
     * @param replyForSuggestion
     */
    boolean reply(ReplyForSuggestion replyForSuggestion);

    /**
     * 修改回复标识
     * @param id
     * @param replyFlag
     * @return
     */
    boolean changeFlag(String id, String replyFlag);

    /**
     * 按id获取回复
     * @param id
     * @return
     */
    ReplyForSuggestion getReplyById(String id);

    boolean delReply(String id);
}
