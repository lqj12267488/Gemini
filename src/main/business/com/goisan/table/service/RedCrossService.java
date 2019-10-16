package com.goisan.table.service;

import com.goisan.system.bean.BaseBean;
import com.goisan.table.bean.RedCross;

import java.util.List;

public interface RedCrossService {

    List<BaseBean> getRedCrossList(BaseBean baseBean);

    String saveRedCross(RedCross baseBean);

    BaseBean getRedCrossById(String id);

    void updateRedCross(BaseBean baseBean);

    void delRedCross(String id);

    RedCross selectRedCross();
}