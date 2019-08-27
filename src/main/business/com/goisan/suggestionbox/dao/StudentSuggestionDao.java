package com.goisan.suggestionbox.dao;

import com.goisan.suggestionbox.bean.ReplyForSuggestion;
import com.goisan.suggestionbox.bean.StudentSuggestion;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @descroption 学生意见
 * @author 郭千恺
 * @version v1.0
 * @date 2018/9/29 09:30
 */
@Repository
public interface StudentSuggestionDao {
    /**
     * 获取学生意见列表
     * @param studentSuggestion
     * @return
     */
    List<StudentSuggestion> getList(StudentSuggestion studentSuggestion);

    void updateViewFlag(String id);

    /**
     * 新增学生意见
     * @param studentSuggestion
     */
    void insert(StudentSuggestion studentSuggestion);

    /**
     * 更新学生意见
     * @param studentSuggestion
     */
    void update(StudentSuggestion studentSuggestion);

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
    void reply(ReplyForSuggestion replyForSuggestion);

    /**
     * 修改回复标识
     * @param studentSuggestion
     */
    void changeFlag(StudentSuggestion studentSuggestion);

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
