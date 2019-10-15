package com.goisan.research.dao;

import com.goisan.research.bean.Research;
import com.goisan.system.bean.BaseBean;

import java.util.List;

public interface ResearchDao {

    List<Research> getResearchList(BaseBean baseBean);

    void saveResearch(Research baseBean);

    BaseBean getResearchById(String id);

    void updateResearch(BaseBean baseBean);

    void delResearch(String id);

    Research selectResearchById(String id);
}
