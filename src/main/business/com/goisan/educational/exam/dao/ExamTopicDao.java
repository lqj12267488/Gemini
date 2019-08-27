package com.goisan.educational.exam.dao;

import com.goisan.educational.exam.bean.ExamTopic;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ExamTopicDao {
    List<ExamTopic> examTopicAction(ExamTopic examTopic);

    void deleteExamTopicById(String id);

    ExamTopic getExamTopicById(String id);

    void updateExamTopicById(ExamTopic examTopic);

    void insertExamTopic(ExamTopic examTopic);
    List<AutoComplete> getExamName();

}
