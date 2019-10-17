package com.goisan.table.dao;

import com.goisan.system.bean.BaseBean;
import com.goisan.table.bean.CourtyardName;

import java.util.List;

public interface CourtyardNameDao {

    List<CourtyardName> getCourtyardNameList(CourtyardName baseBean);

    void saveCourtyardName(BaseBean baseBean);

    BaseBean getCourtyardNameById(String id);

    void updateCourtyardName(BaseBean baseBean);

    void delCourtyardName(String id);

}
