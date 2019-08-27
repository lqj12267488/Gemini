package com.goisan.excellect.service;

import com.goisan.approval.bean.ResourcePublic;
import com.goisan.excellect.bean.ResourceExcellect;
import com.goisan.indexsearch.bean.ResourceView;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

public interface ResourceExcellectService {

    /*
    *  add by yang  liu
    */
    void  saveResourceExcellect(ResourcePublic resourcePublic);
    void  updateResourceExcellect(String id);
    void  saveResourceExcellectPrivate(ResourcePublic resourcePublic);
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
    @Transactional
    Map getHomePageExcellectList(ResourceView resourceView);

    List<ResourceView> searchExcellectList(ResourceView resourceView);

    String countsearchExcellectList(ResourceView resourceView);

    ResourceView searchExcellectResourceById(String resourceId);
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