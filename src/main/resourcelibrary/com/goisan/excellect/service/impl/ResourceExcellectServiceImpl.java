package com.goisan.excellect.service.impl;

import com.goisan.approval.bean.ResourcePublic;
import com.goisan.excellect.bean.ResourceExcellect;
import com.goisan.excellect.dao.ResourceExcellectDao;
import com.goisan.excellect.service.ResourceExcellectService;
import com.goisan.indexsearch.bean.ResourceView;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ResourceExcellectServiceImpl implements ResourceExcellectService {

    /*
    *  add by yang  liu
    */
    @Resource
    private ResourceExcellectDao resourceExcellectDao;


    @Override
    public void saveResourceExcellect(ResourcePublic resourcePublic) {
        resourceExcellectDao.saveResourceExcellect(resourcePublic);
    }

    @Override
    public void updateResourceExcellect(String id) {
        resourceExcellectDao.updateResourceExcellect(id);
    }

    @Override
    public void saveResourceExcellectPrivate(ResourcePublic resourcePublic) {
        resourceExcellectDao.saveResourceExcellectPrivate(resourcePublic);
    }

    @Override
    public List<ResourceExcellect> getResourceExcellectList(ResourceExcellect resourceExcellect) {
        return resourceExcellectDao.getResourceExcellectList(resourceExcellect);
    }

    @Override
    public ResourceExcellect getResourceExcellectById(ResourceExcellect resourceExcellect) {
        return resourceExcellectDao.getResourceExcellectById(resourceExcellect);
    }

    @Override
    public void updateExcellect(ResourceExcellect resourceExcellect) {
        resourceExcellectDao.updateExcellect(resourceExcellect);
    }

    @Override
    public void deleteExcellect(String id) {
        resourceExcellectDao.deleteExcellect(id);
    }


    /*
    *  add by liu  end
    * */

    /*
    *  add by yang  start
    * */
    public Map getHomePageExcellectList(ResourceView resourceView) {
        Map<String, List> map = new HashMap<String, List>();
        resourceView.setEndCount("4");
        resourceView.setResourceFormat("2");
        List<ResourceView> pictureList = resourceExcellectDao.searchExcellectList(resourceView);
        resourceView.setResourceFormat("4");
        List<ResourceView> videoList = resourceExcellectDao.searchExcellectList(resourceView);
        map.put("picture", pictureList);
        map.put("video", videoList);
        return map;
    }

    public List<ResourceView> searchExcellectList(ResourceView resourceView){
        return resourceExcellectDao.searchExcellectList(resourceView);
    }

    public String countsearchExcellectList(ResourceView resourceView){
        return resourceExcellectDao.countsearchExcellectList(resourceView);
    }

    public ResourceView searchExcellectResourceById(String resourceId){
        return resourceExcellectDao.searchExcellectResourceById(resourceId);
    }
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
