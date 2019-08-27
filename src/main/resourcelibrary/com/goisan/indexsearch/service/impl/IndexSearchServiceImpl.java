package com.goisan.indexsearch.service.impl;

import com.goisan.indexsearch.bean.ResourceView;
import com.goisan.indexsearch.dao.IndexSearchDao;
import com.goisan.indexsearch.service.IndexSearchService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/9/29.
 */
@Service
public class IndexSearchServiceImpl implements IndexSearchService{
    @Resource
    private IndexSearchDao indexSearchDao;
    public List<ResourceView> searchResourceList(ResourceView resourceView){
      return indexSearchDao.searchResourceList(resourceView);
    }

    public ResourceView searchResourceById(ResourceView resourceView){
      return indexSearchDao.searchResourceById(resourceView);
    }

    public ResourceView getCountResource(ResourceView resourceView){
      return indexSearchDao.getCountResource(resourceView);
    }

    public String countSearchResource(ResourceView resourceView){
      return indexSearchDao.countSearchResource(resourceView);
    }

    public List<ResourceView> searchResourceContribution(ResourceView resourceView){
        return indexSearchDao.searchResourceContribution(resourceView);
    }

    public List<ResourceView> searchMajorContribution(ResourceView resourceView){
        return indexSearchDao.searchMajorContribution(resourceView);
    }

}
