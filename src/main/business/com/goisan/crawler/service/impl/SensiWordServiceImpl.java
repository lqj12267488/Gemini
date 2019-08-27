package com.goisan.crawler.service.impl;

import com.goisan.crawler.dao.SensiWordDao;
import com.goisan.crawler.service.SensiWordService;
import com.goisan.system.bean.BaseBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SensiWordServiceImpl implements SensiWordService {
@Resource
private SensiWordDao sensiWordDao;

    public List<BaseBean> getSensiWordList(BaseBean baseBean) {
        return sensiWordDao.getSensiWordList(baseBean);
    }

    public void saveSensiWord(BaseBean baseBean) {
        sensiWordDao.saveSensiWord(baseBean);
    }

    public BaseBean getSensiWordById(String id) {
        return sensiWordDao.getSensiWordById(id);
    }

    public void updateSensiWord(BaseBean baseBean) {
        sensiWordDao.updateSensiWord(baseBean);
    }

    public void delSensiWord(String id) {
        sensiWordDao.delSensiWord(id);
    }
}
