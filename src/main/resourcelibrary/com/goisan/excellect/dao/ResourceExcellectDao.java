package com.goisan.excellect.dao;

import com.goisan.approval.bean.ResourcePublic;
import com.goisan.excellect.bean.ResourceExcellect;
import com.goisan.indexsearch.bean.ResourceView;

import java.util.List;

public interface ResourceExcellectDao {

    /*
    *  add by yang  liu
    */
    void saveResourceExcellect(ResourcePublic resourcePublic);
    void updateResourceExcellect(String id);
    void saveResourceExcellectPrivate(ResourcePublic resourcePublic);
    List<ResourceExcellect> getResourceExcellectList(ResourceExcellect resourceExcellect);
    ResourceExcellect getResourceExcellectById(ResourceExcellect resourceExcellect);
    void updateExcellect(ResourceExcellect resourceExcellect);
    void deleteExcellect(String id);
    /*
    *  add by liu  end
    * */
    /*
    *  add by yang  start
    * */
    List<ResourceView> searchExcellectList(ResourceView resourceView);

    String countsearchExcellectList(ResourceView resourceView);

    ResourceView searchExcellectResourceById(String id);
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
