package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.Photography;
import com.goisan.synergy.workflow.dao.PhotographyDao;
import com.goisan.synergy.workflow.service.PhotographyService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/7/26.
 */
@Service
public class PhotographyServiceImpl implements PhotographyService {
    @Resource
    private PhotographyDao photographyDao;
    public List<Photography> getPhotographyList(Photography photography){return photographyDao.getPhotographyList(photography);}
    public void insertPhotography(Photography photography){photographyDao.insertPhotography(photography);}
    public Photography getPhotographyById(String id){return photographyDao.getPhotographyById(id);}
    public void updatePhotographyById(Photography photography){photographyDao.updatePhotographyById(photography);}
    public void deletePhotographyById(String id){photographyDao.deletePhotographyById(id);}
    public List<Photography> getPhotographyListProcess(Photography photography) {
        return photographyDao.getPhotographyListProcess(photography);
    }
    public List<AutoComplete> selectDept() {
        return photographyDao.selectDept();
    }
    public List<Photography> getPhotographyListComplete(Photography photography) {
        return photographyDao.getPhotographyListComplete(photography);
    }
    public String getPersonNameById(String personId) {
        return  photographyDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return photographyDao.getDeptNameById(deptId);
    }
    public List<AutoComplete> selectPerson() {
        return photographyDao.selectPerson();
    }
}

