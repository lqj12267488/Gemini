package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.ScreenUse;
import com.goisan.synergy.workflow.dao.ScreenUseDao;
import com.goisan.synergy.workflow.service.ScreenUseService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/6/28.
 */
@Service
@Transactional()
public class ScreenUseServiceImpl implements ScreenUseService {
    @Resource(name = "screenUseDao")
    private ScreenUseDao screenUseDao;

    //方法上注解属性会覆盖类注解上的相同属性
    @Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW)
    public List<ScreenUse> screenUseAction(ScreenUse screenUse) {
        return screenUseDao.screenUseAction(screenUse);
    }

    public String getPersonNameById(String personId) {
        return screenUseDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return screenUseDao.getDeptNameById(deptId);
    }

    public ScreenUse getScreenUseById(String id) {
        return screenUseDao.getScreenUseById(id);
    }

    public void insertScreenUse(ScreenUse screenUse) {
        screenUseDao.insertScreenUse(screenUse);
    }

    public void updateScreenUse(ScreenUse screenUse) {
        screenUseDao.updateScreenUse(screenUse);
    }

    public void deleteScreenUseById(String id) {
        screenUseDao.deleteScreenUseById(id);
    }

    public List<AutoComplete> selectDept() {
        return screenUseDao.selectDept();
    }

    public List<AutoComplete> selectPerson() {
        return screenUseDao.selectPerson();
    }

    public List<ScreenUse> getScreenUseListProcess(ScreenUse screenUse) {
        return screenUseDao.getScreenUseListProcess(screenUse);
    }

    public List<ScreenUse> getScreenUseListComplete(ScreenUse screenUse) {
        return screenUseDao.getScreenUseListComplete(screenUse);
    }
}
