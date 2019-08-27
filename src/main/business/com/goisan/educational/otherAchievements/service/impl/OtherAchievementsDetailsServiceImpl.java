package com.goisan.educational.otherAchievements.service.impl;

import com.goisan.educational.otherAchievements.bean.OtherAchievements;
import com.goisan.educational.otherAchievements.bean.OtherAchievementsDetails;
import com.goisan.educational.otherAchievements.dao.OtherAchievementsDao;
import com.goisan.educational.otherAchievements.dao.OtherAchievementsDetailsDao;
import com.goisan.educational.otherAchievements.service.OtherAchievementsDetailsService;
import com.goisan.educational.score.bean.ScoreImport;
import com.goisan.system.bean.Select2;
import com.goisan.system.service.CommonService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Service
public class OtherAchievementsDetailsServiceImpl implements OtherAchievementsDetailsService {

    @Autowired
    private OtherAchievementsDetailsDao otherAchievementsDetailsDao;


    @Autowired
    private CommonService commonService;


    @Override
    public List getOtherAchievementsDetailsList(OtherAchievementsDetails otherAchievementsDetails) {
        return otherAchievementsDetailsDao.getOtherAchievementsDetailsList(otherAchievementsDetails);
    }

    @Override
    public OtherAchievementsDetails getOtherAchievementsDetailsById(String id) {
        return otherAchievementsDetailsDao.getOtherAchievementsDetailsById(id);
    }

    @Override
    public void deleteOtherAchievementsDetails(String id) {
        otherAchievementsDetailsDao.deleteOtherAchievementsDetails(id);
    }

    @Override
    public void updateOtherAchievementsDetails(OtherAchievementsDetails otherAchievementsDetails) {
        otherAchievementsDetailsDao.updateOtherAchievementsDetails(otherAchievementsDetails);
    }

    @Override
    public void saveOtherAchievementsDetails(OtherAchievementsDetails otherAchievementsDetails) {
        otherAchievementsDetailsDao.saveOtherAchievementsDetails(otherAchievementsDetails);
    }


    @Override
    public Message saveOtherAchievementsDeatilsCon(HttpServletRequest request){

        try {

         return this.saveScore1(request.getParameterMap().keySet(),request);


        } catch (Exception e){

            e.printStackTrace();
        }

        return new Message(0, "操作失败，请稍后重试！", null);
    }

    @Override
    public void updateCommentStatesByIds(String ids) {
        otherAchievementsDetailsDao.updateCommentStatesByIds(ids);
    }

    @Override
    public void updateOpenFlagsByIds(String ids) {
        otherAchievementsDetailsDao.updateOpenFlagsByIds(ids);
    }


    private Message saveScore1(Set<String> set, HttpServletRequest request){

        try {

            if(set != null && set.size() > 0){

                List<String> notInId = new ArrayList<>(); // 存放每个对象的 list 集合

                List<Select2> ksztList = commonService.getSysDict("KSZT","");  // 考试状态 系统字典

                for(String name : set){

                    if(name != null && !"".equals(name) && !"type".equals(name)){

                        String[] arrStr = name.split("_");  // 将 A_ID 切开

                        if(arrStr.length == 2){

                            String id = arrStr[1]; // 获得id

                            if(id != null && !"".equals(id) && !notInId.contains(id)){ //判断id 是否在notInId 里  如果不在 就加入 notInId

                                notInId.add(id);

                                OtherAchievementsDetails otherAchievementsDetails = otherAchievementsDetailsDao.getOtherAchievementsDetailsById(id);

                                if(otherAchievementsDetails != null){

                                    String A = request.getParameter("A_"+id);
                                    String B = request.getParameter("B_"+id);
                                    String C = request.getParameter("C_"+id);
                                    String D = request.getParameter("D_"+id);
                                    String peacetimeTotal = request.getParameter("peacetimeTotal_"+id);
//                                    String generalComment = request.getParameter("generalComment_"+id);


                                    otherAchievementsDetails.setA(A);
                                    otherAchievementsDetails.setB(B);
                                    otherAchievementsDetails.setC(C);
                                    otherAchievementsDetails.setD(D);
                                    int sum=Integer.parseInt(A)+Integer.parseInt(B)+Integer.parseInt(C)+Integer.parseInt(D);
                                    otherAchievementsDetails.setPeacetimeTotal(sum+"");
                                    //otherAchievementsDetails.setGeneralComment(generalComment);
                                    otherAchievementsDetailsDao.updateOtherAchievementsDetails(otherAchievementsDetails);
                                }
                            }
                        }
                    }
                }

                return new Message(1, "保存成功！", null);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return new Message(0, "操作失败，请稍后重试！", null);
    }








}
