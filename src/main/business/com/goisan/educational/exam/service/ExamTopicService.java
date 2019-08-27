package com.goisan.educational.exam.service;

import com.goisan.educational.exam.bean.ExamTopic;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

public interface ExamTopicService {
    List<ExamTopic> examTopicAction(ExamTopic examTopic);

    void deleteExamTopicById(String id);

    ExamTopic getExamTopicById(String id);

    void updateExamTopicById(ExamTopic examTopic);

    void insertExamTopic(ExamTopic examTopic);

    List<AutoComplete> getExamName();
}
