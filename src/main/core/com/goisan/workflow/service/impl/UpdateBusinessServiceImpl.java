package com.goisan.workflow.service.impl;

import com.goisan.workflow.dao.UpdateBusinessDao;
import com.goisan.workflow.service.UpdateBusinessService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class UpdateBusinessServiceImpl implements UpdateBusinessService {
    @Resource
    private UpdateBusinessDao updateBusinessDao;

    public void update(String id) {
        updateBusinessDao.update(id);
    }
}
