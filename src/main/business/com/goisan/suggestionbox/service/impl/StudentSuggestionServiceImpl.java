package com.goisan.suggestionbox.service.impl;

import com.goisan.suggestionbox.bean.ReplyForSuggestion;
import com.goisan.suggestionbox.bean.StudentSuggestion;
import com.goisan.suggestionbox.dao.StudentSuggestionDao;
import com.goisan.suggestionbox.service.StudentSuggestionService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @descroption 学生意见
 * @author 郭千恺
 * @version v1.0
 * @date 2018/9/29 09:30
 */
@Service
public class StudentSuggestionServiceImpl implements StudentSuggestionService {
    @Resource
    private StudentSuggestionDao studentSuggestionDao;

    /**
     * 获取学生意见列表
     * @param studentSuggestion
     * @return
     */
    public List<StudentSuggestion> getStudentSuggestion(StudentSuggestion studentSuggestion) {
        return this.studentSuggestionDao.getList(studentSuggestion);
    }

    public void updateViewFlag(String id){
        studentSuggestionDao.updateViewFlag(id);
    }

    /**
     * 新增学生意见
     * @param studentSuggestion
     */
    public boolean save(StudentSuggestion studentSuggestion) {
        try {
            String id = studentSuggestion.getId();
            if (id==null || "".equals(id)) {
                studentSuggestion.setReplyFlag("1");
                this.studentSuggestionDao.insert(studentSuggestion);
            } else {
                this.update(studentSuggestion);
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 更新学生意见
     * @param studentSuggestion
     */
    public boolean update(StudentSuggestion studentSuggestion) {
        try {
            this.studentSuggestionDao.update(studentSuggestion);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 按id获取学生意见
     * @param id
     * @return
     */
    public StudentSuggestion getById(String id) {
        try {
            return this.studentSuggestionDao.getById(id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 删除学生意见
     * @param id
     */
    public void delDetails(String id) {
        studentSuggestionDao.delDetails(id);
    }

    /**
     * 回复学生意见
     * @param replyForSuggestion
     */
    public boolean reply(ReplyForSuggestion replyForSuggestion) {
        try {
            String id = replyForSuggestion.getId();
            if (id==null || "".equals(id)) {
                this.studentSuggestionDao.reply(replyForSuggestion);
                this.changeFlag(replyForSuggestion.getId(), "2");
            } else {
                this.studentSuggestionDao.updateReply(replyForSuggestion);
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 修改回复标识
     * @param id
     * @param replyFlag
     */
    public boolean changeFlag(String id, String replyFlag) {
        try {
            switch (replyFlag) {
                case "1" : ;
                case "2" : ;
                case "3" :
                    StudentSuggestion studentSuggestion = new StudentSuggestion();
                    studentSuggestion.setId(id);
                    studentSuggestion.setReplyFlag(replyFlag);
                    this.studentSuggestionDao.changeFlag(studentSuggestion);
                    return true;
                default : throw new Exception("非法的回复标识!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 按id获取回复
     * @param id
     * @return
     */
    public ReplyForSuggestion getReplyById(String id) {
        try {
            return this.studentSuggestionDao.getReplyById(id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean delReply(String id) {
        try {
            ReplyForSuggestion reply = this.getReplyById(id);
            StudentSuggestion suggestion = this.getById(reply.getSuggestionId());
            if (suggestion.getReplyList().size() == 1) {
                this.changeFlag(suggestion.getId(), "1");
            }
            this.studentSuggestionDao.delReply(id);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
