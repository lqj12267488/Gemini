package com.goisan.research.service.impl;

import com.goisan.research.bean.Research;
import com.goisan.research.dao.ResearchDao;
import com.goisan.research.service.ResearchService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.UUID;

@Service
public class ResearchServiceImpl implements ResearchService {

    @Resource
    private ResearchDao researchDao;

    @Override
    public List<Research> getResearchList(BaseBean baseBean) {
        return researchDao.getResearchList(baseBean);
    }

    @Override
    public void saveResearch(Research baseBean) {
        baseBean.setCreateDept(CommonUtil.getDefaultDept());
        baseBean.setCreator(CommonUtil.getPersonId());
        baseBean.setId(UUID.randomUUID().toString());
        researchDao.saveResearch(baseBean);
    }

    @Override
    public BaseBean getResearchById(String id) {
        return researchDao.getResearchById(id);
    }

    @Override
    public void updateResearch(BaseBean baseBean) {
        baseBean.setChangeDept(CommonUtil.getDefaultDept());
        baseBean.setChanger(CommonUtil.getPersonId());

        researchDao.updateResearch(baseBean);
    }

    @Override
    public void delResearch(String id) {
        researchDao.delResearch(id);
    }

    @Override
    public Research selectResearchById(String id) {
        return researchDao.selectResearchById(id);
    }
}
