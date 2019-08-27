package com.goisan.crawler.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface SensiWordDao {

    List<BaseBean> getSensiWordList(BaseBean baseBean);

    void saveSensiWord(BaseBean baseBean);

    BaseBean getSensiWordById(String id);

    void updateSensiWord(BaseBean baseBean);

    void delSensiWord(String id);

}
