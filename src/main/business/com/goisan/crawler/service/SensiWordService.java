package com.goisan.crawler.service;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface SensiWordService {

    List<BaseBean> getSensiWordList(BaseBean baseBean);

    void saveSensiWord(BaseBean baseBean);

    BaseBean getSensiWordById(String id);

    void updateSensiWord(BaseBean baseBean);

    void delSensiWord(String id);

}