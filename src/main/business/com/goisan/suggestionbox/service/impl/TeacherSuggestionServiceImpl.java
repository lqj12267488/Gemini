package com.goisan.suggestionbox.service.impl;

import com.goisan.suggestionbox.bean.ReplyForSuggestion;
import com.goisan.suggestionbox.bean.TeacherSuggestion;
import com.goisan.suggestionbox.dao.TeacherSuggestionDao;
import com.goisan.suggestionbox.service.TeacherSuggestionService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @descroption 教师意见
 * @author 郭千恺
 * @version v1.0
 * @date 2018/9/26 15:48
 */
@Service
public class TeacherSuggestionServiceImpl implements TeacherSuggestionService {
    @Resource
    private TeacherSuggestionDao teacherSuggestionDao;

    /**
     * 获取教师意见列表
     * @param teacherSuggestion
     * @return
     */
    public List<TeacherSuggestion> getTeacherSuggestion(TeacherSuggestion teacherSuggestion) {
        return this.teacherSuggestionDao.getList(teacherSuggestion);
    }

    /**
     * 新增教师意见
     * @param teacherSuggestion
     */
    public boolean save(TeacherSuggestion teacherSuggestion) {
        try {
            String id = teacherSuggestion.getId();
            if (id==null || "".equals(id)) {
                teacherSuggestion.setReplyFlag("1");
                this.teacherSuggestionDao.insert(teacherSuggestion);
            } else {
                this.update(teacherSuggestion);
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 更新教师意见
     * @param teacherSuggestion
     */
    public boolean update(TeacherSuggestion teacherSuggestion) {
        try {
            this.teacherSuggestionDao.update(teacherSuggestion);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 按id获取教师意见
     * @param id
     * @return
     */
    public TeacherSuggestion getById(String id) {
        try {
            return this.teacherSuggestionDao.getById(id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 删除教师意见
     * @param id
     */
    public void del(String id) {
        teacherSuggestionDao.del(id);
    }

    public void updateViewFlag(String id){
        teacherSuggestionDao.updateViewFlag(id);
    }

    /**
     * 回复教师意见
     * @param replyForSuggestion
     */
    public boolean reply(ReplyForSuggestion replyForSuggestion) {
        try {
            String id = replyForSuggestion.getId();
            if (id==null || "".equals(id)) {
                this.teacherSuggestionDao.reply(replyForSuggestion);
                this.changeFlag(replyForSuggestion.getId(), "2");
            } else {
                this.teacherSuggestionDao.updateReply(replyForSuggestion);
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
                    TeacherSuggestion teacherSuggestion = new TeacherSuggestion();
                    teacherSuggestion.setId(id);
                    teacherSuggestion.setReplyFlag(replyFlag);
                    this.teacherSuggestionDao.changeFlag(teacherSuggestion);
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
            return this.teacherSuggestionDao.getReplyById(id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean delReply(String id) {
        try {
            ReplyForSuggestion reply = this.getReplyById(id);
            TeacherSuggestion suggestion = this.getById(reply.getSuggestionId());
            if (suggestion.getReplyList().size() == 1) {
                this.changeFlag(suggestion.getId(), "1");
            }
            this.teacherSuggestionDao.delReply(id);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
