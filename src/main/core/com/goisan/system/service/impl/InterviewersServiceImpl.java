package com.goisan.system.service.impl;

import com.goisan.system.bean.Interviewers;
import com.goisan.system.dao.InterviewersDao;
import com.goisan.system.service.InterviewersService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class InterviewersServiceImpl implements InterviewersService {
    @Resource
    private InterviewersDao interviewersDao;

    public List<Interviewers> interviewersAction(Interviewers interviewers) {
        return interviewersDao.interviewersAction(interviewers);
    }

    public void deleteInterviewersById(String id) {
        interviewersDao.deleteInterviewersById(id);
    }

    public Interviewers getInterviewersById(String id) {
        return interviewersDao.getInterviewersById(id);
    }

    public void updateInterviewersById(Interviewers interviewers) {
        interviewersDao.updateInterviewersById(interviewers);
    }

    public void insertInterviewers(Interviewers interviewers) {
        interviewersDao.insertInterviewers(interviewers);
    }
}
