package com.goisan.educational.exam.service.impl;

import com.goisan.educational.exam.bean.ExamTopic;
import com.goisan.educational.exam.dao.ExamTopicDao;
import com.goisan.educational.exam.service.ExamTopicService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ExamTopicServiceImpl implements ExamTopicService{
    @Resource
    private ExamTopicDao examTopicDao;

    public List<ExamTopic> examTopicAction(ExamTopic examTopic){
        return examTopicDao.examTopicAction(examTopic);
    }

    public void deleteExamTopicById(String id){
        examTopicDao.deleteExamTopicById(id);
    }

    public ExamTopic getExamTopicById(String id){
        return examTopicDao.getExamTopicById(id);
    }

    public void updateExamTopicById(ExamTopic examTopic){
        examTopicDao.updateExamTopicById(examTopic);
    }

    public void insertExamTopic(ExamTopic examTopic){
        examTopicDao.insertExamTopic(examTopic);
    }

    @Override
    public List<AutoComplete> getExamName() {
        return examTopicDao.getExamName();
    }
}
