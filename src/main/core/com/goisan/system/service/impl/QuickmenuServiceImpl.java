package com.goisan.system.service.impl;

import com.goisan.system.bean.LoginUser;
import com.goisan.system.bean.Quickmenu;
import com.goisan.system.bean.Tree;
import com.goisan.system.dao.QuickmenuDao;
import com.goisan.system.service.QuickmenuService;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class QuickmenuServiceImpl implements QuickmenuService {
@Resource
private QuickmenuDao quickmenuDao;

    public List<BaseBean> getQuickmenuList(BaseBean baseBean) {
        return quickmenuDao.getQuickmenuList(baseBean);
    }

    public List<BaseBean> getQuickmenuListByUser(BaseBean baseBean) {
        return quickmenuDao.getQuickmenuListByUser(baseBean);
    }

    public List<BaseBean> getQuickmenuByUserId(String userId) {
        String deptId = "";
        if(userId.equals(CommonUtil.getPersonId())){
            deptId = CommonUtil.getDefaultDept();
        }
        return quickmenuDao.getQuickmenuByUserId(userId , deptId );
    }

    public List<Tree> getMenuListByUserId(Quickmenu quickmenu){
        return quickmenuDao.getMenuListByUserId(quickmenu);
    }

    public void saveQuickmenu(BaseBean baseBean) {
        quickmenuDao.saveQuickmenu(baseBean);
    }

    public BaseBean getQuickmenuById(String id) {
        return quickmenuDao.getQuickmenuById(id);
    }

    public void updateQuickmenu(BaseBean baseBean) {
        quickmenuDao.updateQuickmenu(baseBean);
    }

    public void delQuickmenu(String id) {
        quickmenuDao.delQuickmenu(id);
    }

    public void delQMenu(String userId,String deptId) {
        quickmenuDao.delQMenu( userId, deptId);
    }

    public void saveQMenu(String userId , String mentuValue) {
        String deptId = "";
        Quickmenu quickmenu = new Quickmenu();
        if(userId.equals(CommonUtil.getPersonId())){
            deptId = CommonUtil.getDefaultDept();
        }
        quickmenuDao.delQMenu(userId ,deptId);

        String[] menuList = mentuValue.split(",");
        for(int i = 0;i<menuList.length ; i++ ){
            quickmenu.setUserId(userId);
            quickmenu.setDeptId(deptId);
            quickmenu.setResourceId(menuList[i]);
            int j = i+1;
            quickmenu.setResourceOrder(j+"");
            CommonUtil.save(quickmenu);
            quickmenuDao.saveQuickmenu(quickmenu);
        }
    }

    public List<BaseBean> getMenuListIndex() {
        LoginUser loginUser =  CommonUtil.getLoginUser();
        String userId = loginUser.getPersonId();
        String deptId = loginUser.getDefaultDeptId();
        List list = quickmenuDao.getQuickmenuByUserId(userId , deptId );
        if(null == list || list.size()==0){
            list = quickmenuDao.getQuickmenuByUserId(loginUser.getUserType() , "" );
        }
        return list;
    }

}
