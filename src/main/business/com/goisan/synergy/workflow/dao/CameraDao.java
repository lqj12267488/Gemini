package com.goisan.synergy.workflow.dao;

import com.goisan.synergy.workflow.bean.Camera;
import com.goisan.synergy.workflow.bean.Computer;
import com.goisan.synergy.workflow.bean.HotelStay;
import com.goisan.synergy.workflow.bean.Stamp;
import com.goisan.system.bean.AutoComplete;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/7/19.
 */
@Repository
public interface CameraDao {
    List<Camera> getCameraList(Camera camera);
    void insertCamera(Camera camera);
    void updateCameraById(Camera camera);
    void deleteCameraById(String id);
    //回显,通过修改的id
    Camera getCameraById(String id);
    List<Camera> getCameraListProcess(Camera camera);
    List<AutoComplete> selectDept();
    List<AutoComplete> selectPerson();
    List<Camera> getCameraListComplete(Camera camera);
    String getPersonNameById(String personId);
    String getDeptNameById(String deptId);

}
