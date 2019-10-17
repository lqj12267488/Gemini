package com.goisan.system.service;

import com.goisan.system.bean.Interviewers;

import java.util.List;

public interface InterviewersService {
    List<Interviewers> interviewersAction(Interviewers interviewers);

    void deleteInterviewersById(String id);

    Interviewers getInterviewersById(String id);

    void updateInterviewersById(Interviewers interviewers);

    void insertInterviewers(Interviewers interviewers);
}
