package com.goisan.synergy.workflow.service;

import com.goisan.synergy.workflow.bean.Camera;
import com.goisan.synergy.workflow.bean.HotelStay;
import com.goisan.system.bean.AutoComplete;

import java.util.List;

/**
 * Created by Administrator on 2017/7/19.
 */
public interface CameraService {
    List<Camera> getCameraList(Camera camera);
    void insertCamera(Camera camera);
    void updateCameraById(Camera camera);
    void deleteCameraById(String id);
    Camera getCameraById(String id);
    List<Camera> getCameraListProcess(Camera camera);
    List<AutoComplete> selectDept();
    List<AutoComplete> selectPerson();
    List<Camera> getCameraListComplete(Camera camera);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);
}
