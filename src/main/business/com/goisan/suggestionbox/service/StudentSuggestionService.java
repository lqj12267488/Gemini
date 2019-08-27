package com.goisan.suggestionbox.service;

import com.goisan.suggestionbox.bean.ReplyForSuggestion;
import com.goisan.suggestionbox.bean.StudentSuggestion;

import java.util.List;

/**
 * 学生意见
 * @author 郭千恺
 * @version v1.0
 * @date 2018/9/29 09:30
 */
public interface StudentSuggestionService {
    /**
     * 获取学生意见列表
     * @param studentSuggestion
     * @return
     */
    List<StudentSuggestion> getStudentSuggestion(StudentSuggestion studentSuggestion);
    /**
     * 修改查看标识
     * @param
     * @return
     */
    void updateViewFlag(String id);

    /**
     * 保存学生意见
     * @param studentSuggestion
     */
    boolean save(StudentSuggestion studentSuggestion);

    /**
     * 按id获取学生意见
     * @param id
     * @return
     */
    StudentSuggestion getById(String id);

    /**
     * 删除学生意见
     * @param id
     */
    void delDetails(String id);

    /**
     * 回复学生意见
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
