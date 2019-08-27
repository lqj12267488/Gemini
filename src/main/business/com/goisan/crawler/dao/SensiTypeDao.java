package com.goisan.crawler.dao;

import com.goisan.crawler.bean.SensiWord;
import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface SensiTypeDao {

    List<BaseBean> getSensiTypeList(BaseBean baseBean);

    void saveSensiType(BaseBean baseBean);

    BaseBean getSensiTypeById(String id);

    void updateSensiType(BaseBean baseBean);

    void delSensiType(String id);

    List<SensiWord> getSensiWordBySensiTypeId(String id);
}
