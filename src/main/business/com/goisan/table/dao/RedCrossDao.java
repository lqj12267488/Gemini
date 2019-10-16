package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;
import com.goisan.table.bean.RedCross;

import java.util.List;

public interface RedCrossDao {

    List<BaseBean> getRedCrossList(BaseBean baseBean);

    void saveRedCross(BaseBean baseBean);

    BaseBean getRedCrossById(String id);

    void updateRedCross(BaseBean baseBean);

    void delRedCross(String id);

    RedCross selectRedCross();
}
