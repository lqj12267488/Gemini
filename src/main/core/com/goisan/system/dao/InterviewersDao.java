package com.goisan.system.dao;

import com.goisan.system.bean.Interviewers;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InterviewersDao {
    List<Interviewers> interviewersAction(Interviewers interviewers);

    void deleteInterviewersById(String id);

    Interviewers getInterviewersById(String id);

    void updateInterviewersById(Interviewers interviewers);

    void insertInterviewers(Interviewers interviewers);
}
