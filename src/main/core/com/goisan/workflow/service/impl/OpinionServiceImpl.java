package com.goisan.workflow.service.impl;

import com.goisan.workflow.dao.OpinionDao;
import com.goisan.workflow.service.OpinionService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class OpinionServiceImpl implements OpinionService {
@Resource
private OpinionDao opinionDao;

    public List<BaseBean> getOpinionList(BaseBean baseBean) {
        return opinionDao.getOpinionList(baseBean);
    }

    public void saveOpinion(BaseBean baseBean) {
        opinionDao.saveOpinion(baseBean);
    }

    public BaseBean getOpinionById(String id) {
        return opinionDao.getOpinionById(id);
    }

    public void updateOpinion(BaseBean baseBean) {
        opinionDao.updateOpinion(baseBean);
    }

    public void delOpinion(String id) {
        opinionDao.delOpinion(id);
    }
}
