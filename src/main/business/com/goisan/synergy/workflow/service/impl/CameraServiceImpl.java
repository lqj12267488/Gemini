package com.goisan.synergy.workflow.service.impl;

import com.goisan.synergy.workflow.bean.Camera;
import com.goisan.synergy.workflow.bean.HotelStay;
import com.goisan.synergy.workflow.dao.CameraDao;
import com.goisan.synergy.workflow.service.CameraService;
import com.goisan.synergy.workflow.service.ComputerService;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/7/19.
 */
@Service
public class CameraServiceImpl implements CameraService {
    @Resource
    private CameraDao cameraDao;
    public List<Camera> getCameraList(Camera camera){return cameraDao.getCameraList(camera);}
    public void insertCamera(Camera camera){cameraDao.insertCamera(camera);}
    public Camera getCameraById(String id){return cameraDao.getCameraById(id);}
    public void updateCameraById(Camera camera){cameraDao.updateCameraById(camera);}
    public void deleteCameraById(String id){cameraDao.deleteCameraById(id);}
    public List<Camera> getCameraListProcess(Camera camera) {
        return cameraDao.getCameraListProcess(camera);
    }
    public List<AutoComplete> selectDept() {
        return cameraDao.selectDept();
    }
    public List<Camera> getCameraListComplete(Camera camera) {
        return cameraDao.getCameraListComplete(camera);
    }
    public String getPersonNameById(String personId) {
        return  cameraDao.getPersonNameById(personId);
    }

    public String getDeptNameById(String deptId) {
        return cameraDao.getDeptNameById(deptId);
    }
    public List<AutoComplete> selectPerson() {
        return cameraDao.selectPerson();
    }
}
