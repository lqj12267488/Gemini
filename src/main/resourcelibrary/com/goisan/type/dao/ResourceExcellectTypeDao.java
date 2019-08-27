package com.goisan.type.dao;

import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ResourceExcellectTypeDao {

    /*
    *  add by liu  start
    * */

    List<BaseBean> getJPKResourceTypeList(BaseBean baseBean);

    void saveJPKResourceType(BaseBean baseBean);

    BaseBean getJPKResourceTypeById(String id);

    void updateJPKResourceType(BaseBean baseBean);

    void delJPKResourceType(String id);

    String checkType(String id);

    /*
    *  add by liu  end
    * */

    /*
    *  add by yang  start
    * */

    /*
    *  add by yang  end
    * */

    /*
    *  add by zhou  start
    * */

    /*
    *  add by zhou  end
    * */


}
